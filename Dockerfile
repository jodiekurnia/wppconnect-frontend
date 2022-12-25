FROM node:14-alpine as base
WORKDIR /usr/src/wpp-frontend
COPY package.json yarn.lock ./
RUN yarn install
