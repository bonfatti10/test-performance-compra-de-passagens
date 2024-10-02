# Use uma imagem base com JDK
FROM openjdk:11-jdk-slim

# Defina o diretório de trabalho no container
WORKDIR /opt/gatling

# Instale dependências necessárias e baixe o Gatling
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    unzip gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    mv gatling-charts-highcharts-bundle-3.9.5 gatling && \
    rm gatling-charts-highcharts-bundle-3.9.5-bundle.zip

# Defina o diretório de trabalho para onde o Gatling será executado
WORKDIR /opt/gatling/gatling

# Copie os scripts de simulação para dentro do container
COPY ./user-files/simulations /opt/gatling/gatling/user-files/simulations

# Comando para rodar o Gatling diretamente
ENTRYPOINT ["./bin/gatling.sh"]
