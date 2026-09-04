# Sample Application

Minimal Node.js web application used to demonstrate blue-green deployment to
Azure App Service.

The application intentionally avoids framework dependencies so the repository
stays focused on infrastructure, deployment slots, smoke tests, and rollback.

## Endpoints

- `/` returns a small HTML page with the application version and optional
  environment-specific message.
- `/health` returns a JSON health response for App Service health checks and
  deployment smoke tests.

## Configuration

`APP_MESSAGE` is optional. When set, the root page displays its value. This is
useful for demonstrating slot-specific app settings without introducing
application complexity.

## Local Development

```bash
npm install
npm start
```

Then open:

```text
http://localhost:3000/
http://localhost:3000/health
```

Run tests:

```bash
npm test
```

## Docker

No Dockerfile is included. Azure App Service can run this Node.js application
directly from the source package, and adding a container image would add
registry and image lifecycle concerns that are not needed for this portfolio
scenario.
