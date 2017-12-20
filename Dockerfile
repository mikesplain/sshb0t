# Builder image
FROM golang:alpine AS builder
WORKDIR /go/src/github.com/jessfraz/sshb0t
COPY . .
RUN GOOS=linux GOARCH=arm CGO_ENABLED=0 go build -o sshb0t

# Final image
FROM arm32v7/debian
RUN	apt-get update && \
    apt-get install \
      ca-certificates \
      git --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /go/src/github.com/jessfraz/sshb0t/sshb0t /usr/bin/sshb0t
ENTRYPOINT ["sshb0t"]
