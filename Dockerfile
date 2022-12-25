FROM node:14-alpine as base
WORKDIR /usr/src/wpp-front
COPY package.json yarn.lock ./
RUN yarn install && \
    yarn cache clean

FROM base
WORKDIR /usr/src/wpp-server/
RUN yarn cache clean
COPY . .
EXPOSE 3000
ENTRYPOINT ["npm", "install"]
CMD ["npm", "start"]
