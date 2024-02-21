FROM golang:1.21.5

ENV TOOLS /root
ENV BUILDPATH /go/src/github.com/silastgoes/stock-manager/cmd/stock-manager
ENV BUILDPATH /go/src//cmd/stock-manager

RUN GO111MODULE=on go install github.com/cespare/reflex@latest

ADD scripts/build.sh $TOOLS
ADD scripts/reflex.conf $TOOLS
ADD scripts/run.sh $TOOLS
RUN chmod +x $TOOLS/build.sh
RUN chmod +x $TOOLS/run.sh

WORKDIR $BUILDPATH

EXPOSE 5050
CMD ["/root/run.sh"]
