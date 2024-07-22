FROM ruby:3.3.4-alpine3.20 AS base

RUN apk --no-cache add sudo build-base

WORKDIR /opt/app/

ARG USER_GRUP
ARG USER_NAME
ARG USER_PASW
ARG ROOTS_GID
ARG ROOTS_UID

RUN addgroup -S ${USER_GRUP} -g ${ROOTS_GID}
RUN adduser -S ${USER_NAME} -G ${USER_GRUP} -u ${ROOTS_UID}
RUN echo "${USER_NAME}:${USER_PASW}" | chpasswd
RUN echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers

COPY ./ ./

RUN chown -R ${USER_NAME} ./
RUN chmod 755 Gemfile.lock

USER ${USER_NAME}

RUN bundle install -j 4

CMD bundle exec rake
