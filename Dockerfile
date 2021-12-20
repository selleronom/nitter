FROM alpine:latest as nim
EXPOSE 8080

RUN apk --no-cache add nim nimble git gcc alpine-sdk libsass-dev libffi-dev openssl-dev redis openssh-client

COPY . /src/nitter
WORKDIR /src/nitter

RUN nimble build -y -d:release --passC:"-flto" --passL:"-flto" \
    && strip -s nitter \
    && nimble scss

FROM redis:6-alpine
WORKDIR /src/
RUN apk --no-cache add pcre-dev sqlite-dev
COPY --from=nim /src/nitter/nitter /src/nitter/start.sh /src/nitter/nitter.conf ./
COPY --from=nim /src/nitter/public ./public
CMD ["./start.sh"]
