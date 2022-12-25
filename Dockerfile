FROM node:14-alpine as base
WORKDIR /usr/src/wpp-front
ENV NODE_ENV=production
COPY package.json yarn.lock ./
RUN yarn install --production --pure-lockfile && \
    yarn cache clean

FROM base as build
WORKDIR /usr/src/wpp-front
COPY package.json yarn.lock ./
RUN yarn install --production=true --pure-lockfile && \
    yarn cache clean
COPY . .
RUN yarn build


FROM base
WORKDIR /usr/src/wpp-server/
RUN yarn cache clean
COPY . .
COPY --from=build /usr/src/wpp-front/ /usr/src/wpp-front/
EXPOSE 3000
CMD ["npm", "run", "start"]
