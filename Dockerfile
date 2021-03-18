FROM node:14.13.1-slim as build

WORKDIR /app

COPY password-manager/package.json /app

RUN yarn install && yarn cache clean

COPY password-manager /app

CMD ["yarn", "run", "build"]

