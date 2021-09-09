FROM node:latest

RUN apt-get install git && \
    git clone https://github.com/simplicitesoftware/nodejs-demo.git
WORKDIR nodejs-demo

RUN npm install && \ 
    (npm run start&)

EXPOSE 3000
CMD [ "node", "app.js" ]