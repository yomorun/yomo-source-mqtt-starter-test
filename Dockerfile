FROM golang:buster

RUN apt-get update && \
    apt-get install nano iperf iproute2 iputils-ping -y

RUN http_proxy=http://172.16.101.49:1078 https_proxy=http://172.16.101.49:1078 GO111MODULE=off go get github.com/yomorun/yomo; exit 0
RUN cd $GOPATH/src/github.com/yomorun/yomo && make install

WORKDIR $GOPATH/src/github.com/yomorun/yomo-source-mqtt-starter-test
COPY . .
RUN cp $GOPATH/bin/yomo .
RUN go get -d -v ./...

EXPOSE 5252/udp 8888/udp 2883/tcp 6262/udp 7777/udp 3883/udp

CMD ["./yomo"]
