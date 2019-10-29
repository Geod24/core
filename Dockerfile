# Builder image
FROM alpine:edge as Builder
RUN apk --no-cache install ldc ldc-static
RUN dub build --compiler=${DC}

# Runner image, to be propagated
FROM alpine:edge
LABEL maintainer "André Stein <andre.stein.1985@gmail.com>"
EXPOSE 8080
RUN apk --no-cache install docker
COPY --from=Builder /path/to/dlang-tour /tour/dlang-tour
COPY docker/config.docker.yml /tour/config.yml.tmpl
COPY public /tour/public
COPY docker/docker.start.sh /tour/docker.start.sh

ENTRYPOINT [ "/tour/docker.start.sh" ]
