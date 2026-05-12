pipeline {
    agent any

    // ── Tool versions defined in Jenkins Global Tool Configuration ──
    tools {
        maven 'Maven-3.9'      // Name must match Jenkins > Manage Jenkins > Global Tool Config
        jdk   'JDK-11'         // Name must match your JDK installation
    }

    environment {
        APP_NAME      = 'mywebapp'
        WAR_FILE      = "target/${APP_NAME}.war"
        TOMCAT_URL    = 'http://localhost:8080'          // Change to your Tomcat host
        TOMCAT_USER   = credentials('tomcat-credentials') // Add in Jenkins > Credentials
        DEPLOY_PATH   = "/opt/tomcat/webapps/${APP_NAME}.war"
    }

    stages {

        // ── 1. CHECKOUT ──────────────────────────────────────────────
        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }

        // ── 2. BUILD ─────────────────────────────────────────────────
        stage('Build') {
            steps {
                echo '🔨 Building WAR with Maven...'
                sh 'mvn clean package -DskipTests'
                echo "✅ WAR built: ${WAR_FILE}"
            }
        }

        // ── 3. TEST ──────────────────────────────────────────────────
        stage('Test') {
            steps {
                echo '🧪 Running unit tests...'
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        // ── 4. CODE QUALITY ──────────────────────────────────────────
        stage('Code Quality') {
            steps {
                echo '🔍 Running static analysis...'
                // Uncomment if SonarQube is configured:
                // sh 'mvn sonar:sonar -Dsonar.projectKey=mywebapp'
                sh 'mvn checkstyle:check || echo "Checkstyle warnings found (non-blocking)"'
            }
        }

        // ── 5. ARCHIVE ARTIFACT ──────────────────────────────────────
        stage('Archive') {
            steps {
                echo '📦 Archiving WAR artifact...'
                archiveArtifacts artifacts: "${WAR_FILE}", fingerprint: true
            }
        }

        // ── 6. DEPLOY TO TOMCAT ──────────────────────────────────────
        stage('Deploy to Tomcat') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                }
            }
            steps {
                echo '🚀 Deploying to Apache Tomcat...'

                // Option A: Deploy via Tomcat Manager REST API
                sh """
                    curl -v \\
                        --user ${TOMCAT_USER_USR}:${TOMCAT_USER_PSW} \\
                        --upload-file ${WAR_FILE} \\
                        "${TOMCAT_URL}/manager/text/deploy?path=/${APP_NAME}&update=true"
                """

                // Option B: SCP copy (uncomment if you prefer this approach)
                // sh "scp ${WAR_FILE} user@yourserver:${DEPLOY_PATH}"
                // sh "ssh user@yourserver 'sudo systemctl restart tomcat'"
            }
        }

        // ── 7. SMOKE TEST ────────────────────────────────────────────
        stage('Smoke Test') {
            when {
                anyOf { branch 'main'; branch 'master' }
            }
            steps {
                echo '🩺 Running post-deploy health check...'
                retry(5) {
                    sleep(time: 10, unit: 'SECONDS')
                    sh """
                        curl -f -s "${TOMCAT_URL}/${APP_NAME}/health" | grep '"status":"UP"'
                    """
                }
                echo '✅ Application is live and healthy!'
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline completed successfully!'
            // emailext(subject: "✅ Build #${BUILD_NUMBER} - SUCCESS",
            //          body: "App deployed to ${TOMCAT_URL}/${APP_NAME}",
            //          recipientProviders: [[$class: 'DevelopersRecipientProvider']])
        }
        failure {
            echo '❌ Pipeline FAILED — check console output above.'
            // emailext(subject: "❌ Build #${BUILD_NUMBER} - FAILED", ...)
        }
        always {
            cleanWs()
        }
    }
}
