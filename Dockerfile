FROM ruby:3.0.2-alpine3.14

ARG UID=1001
ARG USER=app
ARG APP_NAME=hello-world
ARG HOME=/home/$USER
ARG APPDIR=$HOME/$APP_NAME

RUN apk update &&\
    apk upgrade &&\
    apk add --no-cache shadow &&\
    apk add --no-cache --virtual .build-deps \
    build-base

RUN groupadd -g $UID -o $USER && \
    useradd -m -u $UID -g $UID -o -s /bin/false $USER

USER $USER
WORKDIR $APPDIR

COPY --chown=$USER Gemfile Gemfile.lock $APP_DIR/
RUN bundle install
COPY --chown=$USER . $APPDIR

USER root
RUN apk del .build-deps

USER $USER

EXPOSE 9292
ENTRYPOINT ["bundle", "exec"]
CMD ["puma"]

