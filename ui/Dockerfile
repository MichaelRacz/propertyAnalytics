FROM node:7.5.0

COPY . /usr/src/app

RUN cd /usr/src/app
RUN npm i
RUN echo '{ "presets": ["react", "es2015"] }' > .babelrc
RUN npm run build

EXPOSE 8080
