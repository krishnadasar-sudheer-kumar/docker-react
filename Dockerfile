# BUILDING THE PRODUCT IMAGE WITH TWO BASE IMAGES

# BUILD THE APPLICATION BINARY - JAR FILE

# 	Specify a base image - 1
FROM node:alpine

# 	Specify a work directory for npm - workaround for V15 of node
WORKDIR /app

#	Copy the necessary local configuration files from the local build context to server context
COPY package.json .

# 	Install dependencies for Node
RUN npm install


COPY . .

#	Specify the default command to run
RUN npm run build

# CMD ["npm", "run", "build"]

#	BUILD THE APPLICATION SERVER IMAGE AND DEPLOY THE JAR FILE

#	Specify the base image - 2
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html

# NO NEED TO SPECIFIY TO RUN THE NGINX server
# The DEFAULT command is set to run nginx server.







# updated 10-1-2020

# In the next lecture, we will be creating a multi-step build in our production Dockerfile. AWS currently will fail if you attempt to use a named builder as shown.

# To remedy this, we should create an unnamed builder like so:

# Instead of this:

# 	FROM node:alpine as builder
# 	WORKDIR '/app'
# 	COPY package.json .
# 	RUN npm install
# 	COPY . .
# 	RUN npm run build
 
# 	FROM nginx
# 	COPY --from=builder /app/build /usr/share/nginx/html

# Do this:

# 	FROM node:alpine
# 	WORKDIR '/app'
# 	COPY package.json .
# 	RUN npm install
# 	COPY . .
# 	RUN npm run build
	 
# 	FROM nginx
# 	COPY --from=0 /app/build /usr/share/nginx/html