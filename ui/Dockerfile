FROM node:7.5.0

COPY . /usr/src/app

RUN cd /usr/src/app
RUN npm --prefix /usr/src/app i
RUN echo '{ "presets": ["react", "es2015"] }' > .babelrc
RUN npm --prefix /usr/src/app build

CMD ["npm", "--prefix", "/usr/src/app", "start"]
EXPOSE 8080
