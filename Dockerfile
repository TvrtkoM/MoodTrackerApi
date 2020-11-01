FROM node:12

COPY . /api

WORKDIR /api

RUN npm ci
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
