# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.10.1

# Copy the local package files to the container's workspace.
ADD ./ src/github.com/urunimi/hello-go

# Build the project inside the container.
RUN go install github.com/urunimi/hello-go

# Delete source code.
RUN find . -name "*.go" -type f -delete
RUN rm -rf src/github.com/urunimi/hello-go/Dockerfile

# Change working dir -> for locating configrations
WORKDIR .

# Run by default when the container starts.
ENTRYPOINT /go/bin/hello-go

# Document that the service listens on port 5000
EXPOSE 5000
