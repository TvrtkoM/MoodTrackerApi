FROM node:12
ARG NPM_TOKEN

COPY . /api

WORKDIR /api

RUN echo "//npm.pkg.github.com/:_authToken=$NPM_TOKEN" > .npmrc
RUN echo "@tvrtkom:registry=https://npm.pkg.github.com" >> .npmrc

RUN npm ci
RUN npm run build

EXPOSE 3000
