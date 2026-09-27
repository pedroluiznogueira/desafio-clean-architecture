FROM golang:1.26 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /out/ordersystem ./cmd/ordersystem

FROM gcr.io/distroless/static-debian12
WORKDIR /
COPY --from=builder /out/ordersystem /ordersystem
COPY --from=builder /app/cmd/ordersystem/.env /.env
ENTRYPOINT ["/ordersystem"]
