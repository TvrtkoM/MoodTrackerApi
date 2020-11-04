# Moodtracker backend

Services for a [client](https://github.com/Tvrtkom/mood-tracker-client)

# Environment

## Set up Postgresql and databae

Install postgresql on your system and create a new database.
Insert database configuration in `.env` according to `.env.example`.

# Handling dependecies
Following should be in .npmrc file:
```
//npm.pkg.github.com/:_authToken=[your personal access token for repositories]
@tvrtkom:registry=https://npm.pkg.github.com
```

# Installing and running
Run `npm ci && npm run build && npm start`.

## Runing in docker
Add GITHUB_AUTH_TOKEN to `.env` file. This is the same auth token from .npmrc file.

Run `docker-compose build && docker-compose up`.
