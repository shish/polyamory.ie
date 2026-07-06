FROM ghcr.io/gohugoio/hugo:v0.162.1 AS build
USER root
RUN apk add graphviz
WORKDIR /src
COPY . /src
RUN ./build.sh
RUN hugo --minify --enableGitInfo
RUN echo ok > public/health

FROM nginx:alpine
RUN apk add curl
HEALTHCHECK --start-period=30s --start-interval=5s --interval=1m --timeout=3s \
    CMD curl --fail http://127.0.0.1:80/health || exit 1
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN sed -i 's/worker_processes *auto;/worker_processes 2;/' /etc/nginx/nginx.conf
COPY --from=build /src/public /usr/share/nginx/html
