const http = require("node:http");
const { readFileSync } = require("node:fs");
const { join } = require("node:path");

const packageJson = JSON.parse(
  readFileSync(join(__dirname, "..", "package.json"), "utf8"),
);

const appVersion = process.env.APP_VERSION || packageJson.version;
const appMessage = process.env.APP_MESSAGE || "No optional message configured.";

function sendJson(response, statusCode, body) {
  response.writeHead(statusCode, {
    "content-type": "application/json; charset=utf-8",
    "cache-control": "no-store",
  });
  response.end(JSON.stringify(body));
}

function sendHtml(response, statusCode, body) {
  response.writeHead(statusCode, {
    "content-type": "text/html; charset=utf-8",
    "cache-control": "no-store",
  });
  response.end(body);
}

function escapeHtml(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

function createServer() {
  return http.createServer((request, response) => {
    const url = new URL(request.url, "http://localhost");

    if (url.pathname === "/health") {
      sendJson(response, 200, {
        status: "ok",
        version: appVersion,
      });
      return;
    }

    if (url.pathname === "/") {
      sendHtml(
        response,
        200,
        `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Azure App Service Blue-Green Sample</title>
  <style>
    body {
      margin: 0;
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
      color: #1f2937;
      background: #f8fafc;
    }
    main {
      max-width: 720px;
      margin: 12vh auto;
      padding: 0 24px;
    }
    h1 {
      margin: 0 0 16px;
      font-size: 2rem;
      line-height: 1.2;
    }
    p {
      margin: 8px 0;
      line-height: 1.6;
    }
    code {
      padding: 2px 6px;
      border-radius: 4px;
      background: #e5e7eb;
    }
  </style>
</head>
<body>
  <main>
    <h1>Azure App Service Blue-Green Sample</h1>
    <p>Application version: <code>${escapeHtml(appVersion)}</code></p>
    <p>Configured message: <code>${escapeHtml(appMessage)}</code></p>
  </main>
</body>
</html>`,
      );
      return;
    }

    sendJson(response, 404, {
      error: "not_found",
    });
  });
}

if (require.main === module) {
  const port = Number(process.env.PORT || 3000);
  createServer().listen(port, () => {
    console.log(`Sample app listening on port ${port}`);
  });
}

module.exports = {
  createServer,
};
