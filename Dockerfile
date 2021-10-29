#
# Production level Dockerfile 
#


# Builder Phase
FROM node:alpine AS builder 

# Set working directory to copy files/application into 
WORKDIR /usr/app/frontend

# Install depenendencies
COPY ./package.json ./ 
RUN npm install 

# Copy over everything else (all source files...etc)
COPY ./ ./ 

# Build the project 
RUN npm run build 

# Note, when doing npm run build, the 'executable' and all other files
#  needed to run the executable, is in the '/usr/app/frontend/build' 
#  directory.


# Run Phase
FROM nginx 

COPY --from=builder /usr/app/frontend/build /usr/share/nginx/html 

# The nginx container by default has the command to start up nginx,
#  so no need to specify a start up command.
