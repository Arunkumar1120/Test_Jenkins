FROM nginx
RUN apt-get update -y
COPY staticwebsite.html /usr/share/nginx/html/index.html
EXPOSE 8085
