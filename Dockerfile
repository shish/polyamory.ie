FROM ruby:3.3 AS tools
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog locales 2>&1 \
    && apt-get -y install git openssh-client iproute2 procps lsb-release \
    # && gem install ruby-debug-ide \
    # && gem install debase \
    && apt-get -y install curl software-properties-common \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get -y install nodejs graphviz \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

# install extra bits
RUN gem install jekyll bundler

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

FROM tools AS build
RUN mkdir /srv/jekyll
WORKDIR /srv/jekyll

COPY Gemfile /srv/jekyll
COPY Gemfile.lock /srv/jekyll
RUN bundle install

COPY . /srv/jekyll
RUN bundle exec jekyll build --destination /tmp/site

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /tmp/site /usr/share/nginx/html
