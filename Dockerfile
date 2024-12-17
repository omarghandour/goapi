# Suggested code may be subject to a license. Learn more: ~LicenseLog:559426227.
# Suggested code may be subject to a license. Learn more: ~LicenseLog:2917997055.
dockerfile
FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]
