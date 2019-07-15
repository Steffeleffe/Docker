FROM amazoncorretto:11 as build

RUN set -ex                                                                          && \
    yum update -y                                                                    && \
    yum install -y binutils                                
COPY Hello.java .
RUN set -ex && \
    javac Hello.java                                                                 && \
    jlink --no-header-files --no-man-pages --compress=2 --strip-debug --add-modules java.base --output jre   && \
    strip -p --strip-unneeded jre/lib/server/libjvm.so 

#FROM amazonlinux:2
FROM ubuntu
WORKDIR /opt/hello
COPY --from=build Hello.class .
COPY --from=build jre/ /opt/jre/
ENV PATH=$PATH:/opt/jre/bin
ENTRYPOINT ["java", "Hello"]


