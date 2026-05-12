# 🚀 MyWebApp — Java WAR · Jenkins · Tomcat

A modern Java web application (Servlet + JSP) deployable on Apache Tomcat, with a full Jenkins CI/CD pipeline.

---

## 📁 Project Structure

```
mywebapp/
├── Jenkinsfile                          ← Jenkins pipeline definition
├── pom.xml                              ← Maven build config (WAR packaging)
└── src/
    └── main/
        ├── java/com/myapp/servlet/
        │   ├── ContactServlet.java      ← Handles POST /contact
        │   └── HealthServlet.java       ← GET /health → {"status":"UP"}
        ├── resources/
        └── webapp/
            ├── index.jsp                ← Main website (full landing page)
            └── WEB-INF/
                ├── web.xml              ← Servlet mappings, error pages
                └── views/
                    ├── 404.jsp
                    └── 500.jsp
```

---

## 🏗️ Step 1 — Build Locally

### Prerequisites
- Java 11+
- Maven 3.6+

```bash
# Build the WAR
mvn clean package

# Output: target/mywebapp.war
```

---

## 🐱 Step 2 — Deploy Manually to Tomcat

1. Start Apache Tomcat (download from https://tomcat.apache.org)
2. Copy the WAR:
   ```bash
   cp target/mywebapp.war /path/to/tomcat/webapps/
   ```
3. Tomcat auto-deploys → open http://localhost:8080/mywebapp
4. Test endpoints:
   - **Homepage:** http://localhost:8080/mywebapp/
   - **Health Check:** http://localhost:8080/mywebapp/health
   - **Contact API:** POST http://localhost:8080/mywebapp/contact

---

## ⚙️ Step 3 — Jenkins Setup

### A. Install Jenkins Plugins
Go to **Manage Jenkins → Plugins** and install:
- Pipeline
- Maven Integration
- Deploy to container (or use `curl` in Jenkinsfile — already configured)
- Git

### B. Configure Tools
**Manage Jenkins → Global Tool Configuration:**
- Add JDK → name it `JDK-11`
- Add Maven → name it `Maven-3.9`

### C. Add Tomcat Credentials
**Manage Jenkins → Credentials → System → Global → Add Credentials:**
- Kind: Username with password
- ID: `tomcat-credentials`
- Username: your Tomcat manager username
- Password: your Tomcat manager password

### D. Enable Tomcat Manager (in Tomcat's tomcat-users.xml)
```xml
<role rolename="manager-script"/>
<user username="jenkins" password="your-password" roles="manager-script"/>
```

### E. Create Jenkins Pipeline Job
1. New Item → Pipeline
2. Source: Git → your repo URL
3. Script Path: `Jenkinsfile`
4. Save → Build Now

---

## 🔄 Pipeline Stages

```
Checkout → Build → Test → Code Quality → Archive → Deploy → Smoke Test
```

| Stage | What it does |
|-------|-------------|
| Checkout | Pulls code from Git |
| Build | `mvn clean package` → produces `.war` |
| Test | `mvn test` → runs JUnit |
| Code Quality | Checkstyle analysis |
| Archive | Saves WAR as Jenkins artifact |
| Deploy | Uploads WAR to Tomcat via Manager API |
| Smoke Test | Hits `/health` endpoint to confirm UP |

---

## 🌐 Live Endpoints

| URL | Description |
|-----|-------------|
| `/mywebapp/` | Main website |
| `/mywebapp/health` | Health check (JSON) |
| `/mywebapp/contact` | Contact form (POST) |

---

## 🔧 Customise

- Change agency name/content in `src/main/webapp/index.jsp`
- Change Tomcat URL in `Jenkinsfile` → `TOMCAT_URL`
- Add a database: include JDBC driver in `pom.xml`, create a DAO class
- Uncomment SonarQube / email notifications in `Jenkinsfile`
