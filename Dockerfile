FROM alpine:latest as download

RUN apk add curl

RUN curl -s https://get-latest.deno.dev/parkuman/pocketcms?no-v=true >> tag.txt

RUN wget https://github.com/parkuman/pocketcms/releases/download/v$(cat tag.txt)/pocketcms_$(cat tag.txt)_linux_amd64.zip \
    && unzip pocketcms_$(cat tag.txt)_linux_amd64.zip \
    && chmod +x /pocketcms

FROM alpine:latest

RUN apk update && apk add --update git build-base ca-certificates && rm -rf /var/cache/apk/*

COPY --from=download /pocketcms /usr/local/bin/pocketcms

# Create a startup script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Copy hooks to a temporary location
COPY ./pb_hooks /tmp/pb_hooks
COPY ./pb_migrations /tmp/pb_migrations

EXPOSE 8090

ENTRYPOINT ["/usr/local/bin/start.sh"]
