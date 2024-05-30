FROM jekyll/jekyll:3.8 AS build
COPY . /srv/jekyll
RUN jekyll build --destination /tmp/site

FROM nginx:alpine
COPY --from=build /tmp/site /usr/share/nginx/html
