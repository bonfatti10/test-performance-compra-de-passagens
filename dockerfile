FROM openjdk:11-jdk-slim

WORKDIR /opt/gatling

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    unzip gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    mv gatling-charts-highcharts-bundle-3.9.5 gatling && \
    rm gatling-charts-highcharts-bundle-3.9.5-bundle.zip

WORKDIR /opt/gatling/gatling

COPY ./user-files/simulations /opt/gatling/gatling/user-files/simulations

ENTRYPOINT ["./bin/gatling.sh"]
