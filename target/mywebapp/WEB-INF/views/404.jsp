<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 — Page Not Found</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@800&family=DM+Sans:wght@300;400&display=swap" rel="stylesheet">
    <style>
        body { font-family:'DM Sans',sans-serif; background:#0a0a0f; color:#f5f2eb;
               display:flex; align-items:center; justify-content:center; min-height:100vh; margin:0; }
        .wrap { text-align:center; }
        h1 { font-family:'Syne',sans-serif; font-size:10rem; font-weight:800;
             letter-spacing:-0.06em; color:#e84d1c; line-height:1; margin:0; }
        p { color:rgba(245,242,235,0.5); margin:1rem 0 2rem; font-size:1.1rem; }
        a { background:#e84d1c; color:#fff; padding:0.75rem 2rem; border-radius:100px;
            text-decoration:none; font-weight:500; }
    </style>
</head>
<body>
    <div class="wrap">
        <h1>404</h1>
        <p>The page you're looking for doesn't exist.</p>
        <a href="${pageContext.request.contextPath}/">Go Home</a>
    </div>
</body>
</html>
