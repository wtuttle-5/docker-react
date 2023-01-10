#setting the base image
FROM node:16-alpine as builder

#setting the workdir
WORKDIR '/app'
#adding in the dependencies
COPY package.json .
RUN npm install
#we do not use volume because we are not updating the source code
COPY . .
RUN npm run build


FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
