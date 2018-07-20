FROM node:8

MAINTAINER Tung Pham

# Create app directory
RUN mkdir -p /usr/src/blog
WORKDIR /usr/src/blog

COPY ./blog/package.json /usr/src/blog

# Install NPM
RUN npm install

EXPOSE 8000

CMD ['gulp']