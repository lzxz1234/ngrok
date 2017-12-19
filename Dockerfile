FROM golang:1.7.6

MAINTAINER lzxz1234 <314946925@qq.com>

COPY . /go

RUN mv src/ngrok . && rm -rf src/* && mv ngrok src/
RUN mkdir -p src/golang.org/x/ && cd src/golang.org/x/ && git clone https://github.com/golang/net net && cd /go && go install net
RUN GOOS=linux GOARCH=386 make release-server
RUN GOOS=linux GOARCH=arm make release-client
RUN GOOS=windows GOARCH=amd64 make release-client
RUN GOOS=darwin GOARCH=amd64 make release-client

EXPOSE 81

ENTRYPOINT ["./bin/linux_386/ngrokd"]