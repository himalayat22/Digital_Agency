<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexaStudio — Digital Craft Agency</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;1,9..40,300&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --ink: #0a0a0f;
            --paper: #f5f2eb;
            --accent: #e84d1c;
            --accent2: #f5a623;
            --muted: #6b6b78;
            --border: rgba(10,10,15,0.12);
            --card-bg: #ffffff;
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--paper);
            color: var(--ink);
            overflow-x: hidden;
        }

        /* ── NOISE TEXTURE OVERLAY ── */
        body::before {
            content: '';
            position: fixed; inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
            pointer-events: none; z-index: 9999; opacity: 0.4;
        }

        /* ── NAVIGATION ── */
        nav {
            position: fixed; top: 0; left: 0; right: 0;
            display: flex; align-items: center; justify-content: space-between;
            padding: 1.25rem 3rem;
            background: rgba(245,242,235,0.85);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            z-index: 100;
            transition: all 0.3s ease;
        }
        .nav-logo {
            font-family: 'Syne', sans-serif;
            font-weight: 800; font-size: 1.4rem;
            letter-spacing: -0.04em; color: var(--ink);
            text-decoration: none;
        }
        .nav-logo span { color: var(--accent); }
        .nav-links { display: flex; gap: 2.5rem; list-style: none; }
        .nav-links a {
            font-size: 0.875rem; font-weight: 400;
            color: var(--muted); text-decoration: none;
            transition: color 0.2s; letter-spacing: 0.02em;
        }
        .nav-links a:hover { color: var(--ink); }
        .nav-cta {
            background: var(--ink); color: var(--paper) !important;
            padding: 0.55rem 1.4rem; border-radius: 100px;
            font-weight: 500 !important;
            transition: background 0.2s !important, color 0.2s !important;
        }
        .nav-cta:hover { background: var(--accent) !important; color: white !important; }

        /* ── HERO ── */
        .hero {
            min-height: 100vh;
            padding: 10rem 3rem 6rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            gap: 4rem;
            max-width: 1400px; margin: 0 auto;
        }
        .hero-badge {
            display: inline-flex; align-items: center; gap: 0.5rem;
            background: var(--ink); color: var(--paper);
            font-size: 0.75rem; font-weight: 500; letter-spacing: 0.08em;
            text-transform: uppercase; padding: 0.4rem 1rem;
            border-radius: 100px; margin-bottom: 2rem;
            animation: fadeUp 0.6s ease both;
        }
        .hero-badge::before {
            content: ''; width: 6px; height: 6px; border-radius: 50%;
            background: var(--accent2); animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(1.4); }
        }

        h1 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(3rem, 6vw, 5.5rem);
            font-weight: 800;
            line-height: 1.0;
            letter-spacing: -0.04em;
            animation: fadeUp 0.7s 0.1s ease both;
        }
        h1 em {
            font-style: normal;
            color: var(--accent);
            position: relative;
        }
        h1 em::after {
            content: '';
            position: absolute; bottom: 4px; left: 0; right: 0;
            height: 3px; background: var(--accent);
            transform: scaleX(0); transform-origin: left;
            animation: underlineIn 0.5s 0.8s ease forwards;
        }
        @keyframes underlineIn { to { transform: scaleX(1); } }

        .hero-desc {
            font-size: 1.125rem; color: var(--muted);
            line-height: 1.75; margin-top: 1.75rem; max-width: 440px;
            font-weight: 300;
            animation: fadeUp 0.7s 0.2s ease both;
        }
        .hero-actions {
            display: flex; gap: 1rem; align-items: center; margin-top: 2.5rem;
            animation: fadeUp 0.7s 0.3s ease both;
        }
        .btn-primary {
            background: var(--accent); color: white;
            padding: 0.9rem 2.2rem; border-radius: 100px;
            font-weight: 500; font-size: 0.95rem;
            text-decoration: none; border: none; cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 20px rgba(232,77,28,0.35);
            display: inline-block;
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(232,77,28,0.45); }
        .btn-secondary {
            color: var(--ink); font-weight: 500; font-size: 0.95rem;
            text-decoration: none; display: flex; align-items: center; gap: 0.5rem;
        }
        .btn-secondary:hover { color: var(--accent); }
        .btn-secondary::after { content: '→'; transition: transform 0.2s; }
        .btn-secondary:hover::after { transform: translateX(4px); }

        /* ── HERO VISUAL ── */
        .hero-visual {
            position: relative;
            animation: fadeIn 1s 0.4s ease both;
        }
        .hero-card {
            background: var(--ink);
            border-radius: 24px;
            padding: 3rem;
            color: var(--paper);
            position: relative;
            overflow: hidden;
        }
        .hero-card::before {
            content: '';
            position: absolute; top: -50%; right: -30%;
            width: 300px; height: 300px;
            background: radial-gradient(circle, var(--accent) 0%, transparent 70%);
            opacity: 0.3;
        }
        .hero-card-label {
            font-size: 0.75rem; text-transform: uppercase;
            letter-spacing: 0.1em; color: rgba(245,242,235,0.5);
            margin-bottom: 2rem;
        }
        .metric-grid {
            display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;
            margin-bottom: 2rem;
        }
        .metric-num {
            font-family: 'Syne', sans-serif;
            font-size: 3rem; font-weight: 800;
            letter-spacing: -0.04em; color: var(--paper);
        }
        .metric-num span { color: var(--accent); }
        .metric-label { font-size: 0.8rem; color: rgba(245,242,235,0.5); margin-top: 0.25rem; }
        .hero-bar { height: 4px; background: rgba(255,255,255,0.1); border-radius: 2px; margin-top: 2rem; }
        .hero-bar-fill {
            height: 100%; background: linear-gradient(90deg, var(--accent), var(--accent2));
            border-radius: 2px; width: 0;
            animation: barFill 1.5s 1s ease forwards;
        }
        @keyframes barFill { to { width: 78%; } }

        /* ── MARQUEE ── */
        .marquee-section {
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            padding: 1.2rem 0;
            overflow: hidden; white-space: nowrap;
            background: var(--ink); color: var(--paper);
        }
        .marquee-track {
            display: inline-flex; gap: 3rem;
            animation: marquee 20s linear infinite;
        }
        .marquee-item {
            font-family: 'Syne', sans-serif;
            font-size: 0.8rem; font-weight: 600;
            text-transform: uppercase; letter-spacing: 0.15em;
            opacity: 0.5;
        }
        .marquee-dot { color: var(--accent); opacity: 1 !important; }
        @keyframes marquee { to { transform: translateX(-50%); } }

        /* ── SERVICES ── */
        .services {
            max-width: 1400px; margin: 0 auto;
            padding: 8rem 3rem;
        }
        .section-header {
            display: flex; align-items: flex-end;
            justify-content: space-between; margin-bottom: 4rem;
        }
        .section-tag {
            font-size: 0.75rem; font-weight: 600;
            text-transform: uppercase; letter-spacing: 0.1em;
            color: var(--accent); margin-bottom: 1rem;
        }
        h2 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(2rem, 4vw, 3.5rem);
            font-weight: 800; letter-spacing: -0.04em;
            line-height: 1.05;
        }
        .section-desc { color: var(--muted); font-size: 1rem; max-width: 300px; text-align: right; line-height: 1.7; }
        .services-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 1.5px; background: var(--border);
            border: 1px solid var(--border); border-radius: 20px; overflow: hidden;
        }
        .service-card {
            background: var(--card-bg);
            padding: 2.5rem;
            transition: background 0.25s;
            position: relative; overflow: hidden;
        }
        .service-card:hover { background: var(--ink); }
        .service-card:hover .service-title,
        .service-card:hover .service-desc,
        .service-card:hover .service-num { color: var(--paper); }
        .service-card:hover .service-icon { background: var(--accent); }
        .service-num {
            font-family: 'Syne', sans-serif;
            font-size: 0.75rem; color: var(--muted);
            margin-bottom: 2rem; transition: color 0.25s;
        }
        .service-icon {
            width: 52px; height: 52px; border-radius: 14px;
            background: var(--paper); display: flex; align-items: center;
            justify-content: center; font-size: 1.5rem;
            margin-bottom: 1.5rem; transition: background 0.25s;
        }
        .service-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.25rem; font-weight: 700;
            margin-bottom: 0.75rem; transition: color 0.25s;
        }
        .service-desc {
            font-size: 0.875rem; color: var(--muted);
            line-height: 1.7; transition: color 0.25s;
        }

        /* ── WORK / PROJECTS ── */
        .work {
            background: var(--ink); padding: 8rem 3rem;
        }
        .work-inner { max-width: 1400px; margin: 0 auto; }
        .work h2, .work .section-tag { color: var(--paper); }
        .work .section-desc { color: rgba(245,242,235,0.5); }
        .projects-grid {
            display: grid; grid-template-columns: 2fr 1fr;
            gap: 1.5rem; margin-top: 4rem;
        }
        .project-card {
            border-radius: 20px; overflow: hidden;
            aspect-ratio: 16/10;
            position: relative;
            cursor: pointer;
        }
        .project-card-inner {
            width: 100%; height: 100%;
            display: flex; align-items: flex-end; padding: 2rem;
            transition: transform 0.4s ease;
        }
        .project-card:hover .project-card-inner { transform: scale(1.03); }
        .proj-1 { background: linear-gradient(135deg, #1a1a2e 0%, #e84d1c 100%); }
        .proj-2 { background: linear-gradient(135deg, #0f3460 0%, #f5a623 100%); }
        .proj-3 { background: linear-gradient(135deg, #1b4332 0%, #40916c 100%); aspect-ratio: 1; }
        .project-meta {
            background: rgba(0,0,0,0.4); backdrop-filter: blur(10px);
            border-radius: 12px; padding: 1rem 1.25rem;
        }
        .project-tag {
            font-size: 0.7rem; text-transform: uppercase;
            letter-spacing: 0.1em; color: rgba(255,255,255,0.6); margin-bottom: 0.25rem;
        }
        .project-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.1rem; font-weight: 700; color: white;
        }
        .side-projects { display: flex; flex-direction: column; gap: 1.5rem; }

        /* ── STATS ── */
        .stats {
            max-width: 1400px; margin: 0 auto;
            padding: 8rem 3rem;
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        }
        .stat-card {
            padding: 2.5rem;
            border: 1px solid var(--border);
            border-radius: 20px;
            transition: border-color 0.25s, transform 0.25s;
        }
        .stat-card:hover { border-color: var(--accent); transform: translateY(-4px); }
        .stat-num {
            font-family: 'Syne', sans-serif;
            font-size: 3.5rem; font-weight: 800;
            letter-spacing: -0.04em; color: var(--ink);
        }
        .stat-num sub { font-size: 1.5rem; color: var(--accent); }
        .stat-label { font-size: 0.875rem; color: var(--muted); margin-top: 0.5rem; line-height: 1.5; }

        /* ── CONTACT ── */
        .contact {
            background: var(--accent);
            padding: 8rem 3rem;
        }
        .contact-inner {
            max-width: 900px; margin: 0 auto; text-align: center;
        }
        .contact h2 { color: white; margin-bottom: 1rem; }
        .contact p { color: rgba(255,255,255,0.8); font-size: 1.1rem; margin-bottom: 3rem; }
        .contact-form {
            background: white; border-radius: 24px;
            padding: 3rem; text-align: left;
            box-shadow: 0 40px 80px rgba(0,0,0,0.2);
        }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem; }
        .form-group { display: flex; flex-direction: column; gap: 0.5rem; }
        .form-group label { font-size: 0.8rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.05em; color: var(--muted); }
        .form-group input, .form-group textarea {
            border: 1.5px solid var(--border); border-radius: 12px;
            padding: 0.875rem 1rem; font-family: inherit;
            font-size: 0.95rem; outline: none; resize: none;
            transition: border-color 0.2s;
            background: var(--paper);
        }
        .form-group input:focus, .form-group textarea:focus { border-color: var(--accent); }
        .form-group textarea { min-height: 120px; }
        .form-submit {
            width: 100%; background: var(--ink); color: white;
            padding: 1rem; border: none; border-radius: 12px;
            font-family: 'Syne', sans-serif; font-size: 1rem; font-weight: 700;
            cursor: pointer; transition: background 0.2s;
            letter-spacing: -0.01em;
        }
        .form-submit:hover { background: var(--accent); }
        #form-msg {
            margin-top: 1rem; padding: 0.875rem 1rem;
            border-radius: 10px; font-size: 0.875rem;
            display: none; font-weight: 500;
        }
        #form-msg.success { background: #d1fae5; color: #065f46; display: block; }
        #form-msg.error { background: #fee2e2; color: #991b1b; display: block; }

        /* ── FOOTER ── */
        footer {
            background: var(--ink); padding: 3rem;
            display: flex; align-items: center; justify-content: space-between;
        }
        .footer-logo {
            font-family: 'Syne', sans-serif;
            font-weight: 800; font-size: 1.2rem;
            color: var(--paper); letter-spacing: -0.04em;
        }
        .footer-logo span { color: var(--accent); }
        .footer-copy { font-size: 0.8rem; color: rgba(245,242,235,0.4); }
        .footer-links { display: flex; gap: 2rem; }
        .footer-links a {
            font-size: 0.8rem; color: rgba(245,242,235,0.4);
            text-decoration: none; transition: color 0.2s;
        }
        .footer-links a:hover { color: var(--paper); }

        /* ── ANIMATIONS ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; } to { opacity: 1; }
        }

        /* ── SCROLL REVEAL ── */
        .reveal {
            opacity: 0; transform: translateY(30px);
            transition: opacity 0.65s ease, transform 0.65s ease;
        }
        .reveal.visible { opacity: 1; transform: translateY(0); }

        /* ── RESPONSIVE ── */
        @media (max-width: 900px) {
            nav { padding: 1rem 1.5rem; }
            .nav-links { display: none; }
            .hero { grid-template-columns: 1fr; padding: 8rem 1.5rem 4rem; }
            .hero-visual { display: none; }
            .services-grid { grid-template-columns: 1fr; }
            .projects-grid { grid-template-columns: 1fr; }
            .stats { grid-template-columns: 1fr 1fr; padding: 4rem 1.5rem; }
            .services, .work-inner { padding-left: 1.5rem; padding-right: 1.5rem; }
            .section-header { flex-direction: column; align-items: flex-start; gap: 1rem; }
            .section-desc { text-align: left; }
            .form-row { grid-template-columns: 1fr; }
            footer { flex-direction: column; gap: 1.5rem; text-align: center; }
            .footer-links { justify-content: center; }
        }
    </style>
</head>
<body>

<!-- ── NAVIGATION ── -->
<nav>
    <a href="#" class="nav-logo">Nexa<span>.</span>Studio</a>
    <ul class="nav-links">
        <li><a href="#services">Services</a></li>
        <li><a href="#work">Work</a></li>
        <li><a href="#about">About</a></li>
        <li><a href="#contact" class="nav-cta">Get in Touch</a></li>
    </ul>
</nav>

<!-- ── HERO ── -->
<section class="hero">
    <div class="hero-content">
        <div class="hero-badge">✦ Available for Projects</div>
        <h1>We Build <em>Digital</em><br>Experiences</h1>
        <p class="hero-desc">
            A full-service digital agency crafting high-performance web applications,
            brand identities, and scalable products that grow with your business.
        </p>
        <div class="hero-actions">
            <a href="#work" class="btn-primary">View Our Work</a>
            <a href="#contact" class="btn-secondary">Start a Project</a>
        </div>
    </div>

    <div class="hero-visual">
        <div class="hero-card">
            <div class="hero-card-label">Live Project Dashboard</div>
            <div class="metric-grid">
                <div>
                    <div class="metric-num">48<span>+</span></div>
                    <div class="metric-label">Projects Shipped</div>
                </div>
                <div>
                    <div class="metric-num">99<span>%</span></div>
                    <div class="metric-label">Client Satisfaction</div>
                </div>
                <div>
                    <div class="metric-num">12<span>k</span></div>
                    <div class="metric-label">Users Served</div>
                </div>
                <div>
                    <div class="metric-num">5<span>★</span></div>
                    <div class="metric-label">Avg. Rating</div>
                </div>
            </div>
            <div style="font-size:0.75rem;color:rgba(245,242,235,0.4);margin-bottom:0.5rem;">Project completion rate</div>
            <div class="hero-bar"><div class="hero-bar-fill"></div></div>
        </div>
    </div>
</section>

<!-- ── MARQUEE ── -->
<div class="marquee-section">
    <div class="marquee-track">
        <span class="marquee-item">Web Design</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Java Development</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Cloud Deployment</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Jenkins CI/CD</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Apache Tomcat</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">UI/UX Design</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Brand Identity</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Performance Optimisation</span>
        <span class="marquee-item marquee-dot">✦</span>
        <!-- duplicate for seamless loop -->
        <span class="marquee-item">Web Design</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Java Development</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Cloud Deployment</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Jenkins CI/CD</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Apache Tomcat</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">UI/UX Design</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Brand Identity</span>
        <span class="marquee-item marquee-dot">✦</span>
        <span class="marquee-item">Performance Optimisation</span>
        <span class="marquee-item marquee-dot">✦</span>
    </div>
</div>

<!-- ── SERVICES ── -->
<section class="services" id="services">
    <div class="section-header reveal">
        <div>
            <div class="section-tag">What We Do</div>
            <h2>Our Core<br>Services</h2>
        </div>
        <p class="section-desc">We combine strategy, design, and engineering to build products that matter.</p>
    </div>
    <div class="services-grid reveal">
        <div class="service-card">
            <div class="service-num">01</div>
            <div class="service-icon">⚡</div>
            <div class="service-title">Web Development</div>
            <p class="service-desc">Full-stack Java applications built with Spring, Servlets, and deployed on enterprise Tomcat servers. Scalable and production-ready.</p>
        </div>
        <div class="service-card">
            <div class="service-num">02</div>
            <div class="service-icon">🎨</div>
            <div class="service-title">UI/UX Design</div>
            <p class="service-desc">User interfaces that feel intuitive and look stunning. We research, prototype, and ship polished experiences your users will love.</p>
        </div>
        <div class="service-card">
            <div class="service-num">03</div>
            <div class="service-icon">🚀</div>
            <div class="service-title">CI/CD Pipelines</div>
            <p class="service-desc">Jenkins + Maven + Tomcat automation pipelines. One git push, automatic build, test, and deployment. Zero-downtime releases.</p>
        </div>
        <div class="service-card">
            <div class="service-num">04</div>
            <div class="service-icon">🔒</div>
            <div class="service-title">Security & Auth</div>
            <p class="service-desc">Secure authentication flows, HTTPS, CSRF protection, and OWASP-compliant code for enterprise applications.</p>
        </div>
        <div class="service-card">
            <div class="service-num">05</div>
            <div class="service-icon">📊</div>
            <div class="service-title">Analytics & Monitoring</div>
            <p class="service-desc">Real-time dashboards, performance monitoring, and health-check endpoints to keep your application running at peak performance.</p>
        </div>
        <div class="service-card">
            <div class="service-num">06</div>
            <div class="service-icon">☁️</div>
            <div class="service-title">Cloud Infrastructure</div>
            <p class="service-desc">AWS, Azure, or GCP. Containerised deployments, auto-scaling, and cost-optimised architecture for modern applications.</p>
        </div>
    </div>
</section>

<!-- ── WORK ── -->
<section class="work" id="work">
    <div class="work-inner">
        <div class="section-header reveal">
            <div>
                <div class="section-tag">Selected Work</div>
                <h2>Recent<br>Projects</h2>
            </div>
            <p class="section-desc">A showcase of interfaces, applications, and digital products we've shipped.</p>
        </div>
        <div class="projects-grid reveal">
            <div class="project-card">
                <div class="project-card-inner proj-1">
                    <div class="project-meta">
                        <div class="project-tag">E-Commerce · Java · Spring Boot</div>
                        <div class="project-title">ShopFlow — Retail Platform</div>
                    </div>
                </div>
            </div>
            <div class="side-projects">
                <div class="project-card" style="flex:1">
                    <div class="project-card-inner proj-2" style="aspect-ratio:unset;height:100%">
                        <div class="project-meta">
                            <div class="project-tag">SaaS · Dashboard</div>
                            <div class="project-title">DataLens Analytics</div>
                        </div>
                    </div>
                </div>
                <div class="project-card" style="flex:1">
                    <div class="project-card-inner proj-3" style="aspect-ratio:unset;height:100%">
                        <div class="project-meta">
                            <div class="project-tag">Fintech · API</div>
                            <div class="project-title">GreenPay Wallet</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ── STATS ── -->
<section id="about">
    <div class="stats reveal">
        <div class="stat-card">
            <div class="stat-num">48<sub>+</sub></div>
            <div class="stat-label">Projects shipped across 12 industries worldwide</div>
        </div>
        <div class="stat-card">
            <div class="stat-num">6<sub>yr</sub></div>
            <div class="stat-label">Years of Java enterprise development experience</div>
        </div>
        <div class="stat-card">
            <div class="stat-num">99<sub>%</sub></div>
            <div class="stat-label">Uptime SLA maintained across all client deployments</div>
        </div>
        <div class="stat-card">
            <div class="stat-num">3×<sub></sub></div>
            <div class="stat-label">Faster delivery with automated CI/CD pipelines</div>
        </div>
    </div>
</section>

<!-- ── CONTACT ── -->
<section class="contact" id="contact">
    <div class="contact-inner">
        <div class="section-tag" style="color:rgba(255,255,255,0.7)">Get In Touch</div>
        <h2 style="margin-bottom:1rem;">Let's Build Something<br>Great Together</h2>
        <p>Tell us about your project and we'll get back to you within 24 hours.</p>

        <div class="contact-form reveal">
            <div class="form-row">
                <div class="form-group">
                    <label>Your Name</label>
                    <input type="text" id="f-name" placeholder="John Smith">
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" id="f-email" placeholder="john@example.com">
                </div>
            </div>
            <div class="form-group" style="margin-bottom:1.5rem">
                <label>Message</label>
                <textarea id="f-message" placeholder="Tell us about your project — what are you building, what's the timeline, and what do you need from us?"></textarea>
            </div>
            <button class="form-submit" onclick="submitForm()">Send Message →</button>
            <div id="form-msg"></div>
        </div>
    </div>
</section>

<!-- ── FOOTER ── -->
<footer>
    <div class="footer-logo">Nexa<span>.</span>Studio</div>
    <div class="footer-copy">© 2025 NexaStudio. Deployed via Jenkins + Tomcat.</div>
    <div class="footer-links">
        <a href="#services">Services</a>
        <a href="#work">Work</a>
        <a href="#contact">Contact</a>
        <a href="${pageContext.request.contextPath}/health">Health</a>
    </div>
</footer>

<script>
// ── SCROLL REVEAL ──
const observer = new IntersectionObserver(entries => {
    entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.1 });
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// ── NAV SCROLL EFFECT ──
window.addEventListener('scroll', () => {
    document.querySelector('nav').style.boxShadow =
        window.scrollY > 50 ? '0 4px 30px rgba(0,0,0,0.08)' : 'none';
});

// ── CONTACT FORM ──
async function submitForm() {
    const name    = document.getElementById('f-name').value.trim();
    const email   = document.getElementById('f-email').value.trim();
    const message = document.getElementById('f-message').value.trim();
    const msgEl   = document.getElementById('form-msg');

    msgEl.className = ''; msgEl.style.display = 'none';

    if (!name || !email || !message) {
        msgEl.textContent = 'Please fill in all fields.';
        msgEl.className = 'error'; return;
    }

    const btn = document.querySelector('.form-submit');
    btn.textContent = 'Sending…'; btn.disabled = true;

    try {
        const fd = new FormData();
        fd.append('name', name); fd.append('email', email); fd.append('message', message);

        const res  = await fetch('${pageContext.request.contextPath}/contact', { method: 'POST', body: fd });
        const data = await res.json();

        if (data.success) {
            msgEl.textContent = data.message;
            msgEl.className = 'success';
            document.getElementById('f-name').value = '';
            document.getElementById('f-email').value = '';
            document.getElementById('f-message').value = '';
        } else {
            msgEl.textContent = data.message || 'Something went wrong.';
            msgEl.className = 'error';
        }
    } catch (err) {
        msgEl.textContent = 'Network error. Please try again.';
        msgEl.className = 'error';
    }
    btn.textContent = 'Send Message →'; btn.disabled = false;
}
</script>

</body>
</html>
