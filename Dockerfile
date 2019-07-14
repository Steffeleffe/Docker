FROM amazoncorretto as build
COPY Hello.java .
RUN javac Hello.java

FROM amazoncorretto
WORKDIR /opt/hello
COPY --from=build Hello.class .
ENTRYPOINT ["java", "Hello"]


