# syntax=docker/dockerfile:1

# Fetch
FROM golang:1.23.4 AS fetch-stage
COPY . /frontend/

# Generate
FROM ghcr.io/a-h/templ:latest AS generate-stage
COPY --from=fetch-stage --chown=65532:65532 /frontend/ /frontend/
WORKDIR /frontend
RUN ["templ", "generate"]

# Build
FROM golang:1.23.4 AS build-stage
COPY --from=generate-stage /frontend /frontend/
WORKDIR /frontend
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /frontend/main ./frontend

# Deploy
FROM alpine:latest AS deploy-stage
WORKDIR /frontend
COPY --from=build-stage /frontend/ ./

ENTRYPOINT ["/frontend/main"]
EXPOSE 80
EXPOSE 443