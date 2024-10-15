# Stage 1: Build the Go binary
FROM golang:1.23-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code to the container
COPY . .

# Build the Go binary
RUN go build -o GoAPIProject

# Stage 2: Create the minimal runtime image
FROM alpine:latest

# Set the working directory for the runtime container
WORKDIR /root/

# Copy the built binary from the builder stage
COPY --from=builder /app/GoAPIProject .

# Expose the application port
EXPOSE 8080

# Set the command to run the application
CMD ["./GoAPIProject"]
