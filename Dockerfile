FROM jekyll/jekyll:3.8 AS build
COPY . /srv/jekyll
RUN jekyll build --destination /tmp/site

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /tmp/site /usr/share/nginx/html
