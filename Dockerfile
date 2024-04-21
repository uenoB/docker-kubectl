FROM debian:12 AS build
RUN apt-get update
RUN apt-get install -y busybox-static
ARG VERSION
COPY kubectl-$VERSION /bin/kubectl
RUN chmod +x /bin/kubectl

FROM gcr.io/distroless/static-debian12
COPY --from=build /bin/busybox /bin/kubectl /bin
RUN ["busybox", "--install"]
CMD ["sh"]
