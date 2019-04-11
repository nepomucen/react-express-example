# Use a lighter version of Node as a parent image
FROM mhart/alpine-node:8.11.4 as builder
# Set the working directory to /api
WORKDIR /client
# copy package.json into the container at /client
COPY package*.json /client/
# install dependencies
RUN npm install
# Copy the current directory contents into the container at /client
COPY src/ src/
COPY public/ public/
COPY ./env.sh ./public/
COPY ./.env ./public/
# Add bash
RUN apk add --no-cache bash
# Make our shell script executable
RUN chmod +x ./public/env.sh
# Make port 3000 available to the world outside this container
EXPOSE 3000
# Read-in env variable and run the app when the container launches
CMD ["/bin/bash","-c", "/client/public/env.sh && yarn start"]
#CMD ["yarn", "start"]

