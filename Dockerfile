FROM golang:latest AS builder

WORKDIR /app

RUN git clone https://github.com/kiwiirc/webircgateway.git

RUN cd webircgateway && CGO_ENABLED=0 GOOS=linux go build

RUN ls /app/webircgateway

FROM scratch 

LABEL maintainer="Jeremy.Bouse@UnderGrid.net"
LABEL maintainer="Alex@hirana.net"

COPY --from=builder /app/webircgateway/webircgateway /app/
COPY --from=builder /app/webircgateway/config.conf.example /app/cfg/config.conf

WORKDIR /app

EXPOSE 80 

ENTRYPOINT ["./webircgateway"]
CMD ["-config","cfg/config.conf"]