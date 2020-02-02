FROM golang:1.13.7-alpine AS build

RUN apk add --no-cache git

RUN go get github.com/ndecker/fritzbox_exporter/
WORKDIR ${GOPATH}/src/github.com/ndecker/fritzbox_exporter
RUN CGO_ENABLED=0 go build -o /bin/fritzbox_exporter

FROM scratch
COPY --from=build /bin/fritzbox_exporter /bin/fritzbox_exporter
EXPOSE 9133
ENTRYPOINT [ "/bin/fritzbox_exporter" ]