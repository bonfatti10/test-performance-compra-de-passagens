FROM openjdk:11-jdk-slim

# Define o diretório de trabalho
WORKDIR /opt/gatling

# Atualiza o sistema, instala dependências e baixa o Gatling
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.9.5/gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    unzip gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    mv gatling-charts-highcharts-bundle-3.9.5 gatling && \
    rm gatling-charts-highcharts-bundle-3.9.5-bundle.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho do Gatling
WORKDIR /opt/gatling/gatling

# Copia os arquivos de simulação para o diretório do Gatling
COPY ./user-files/simulations /opt/gatling/gatling/user-files/simulations

# Torna o script gatling.sh executável
RUN chmod +x ./bin/gatling.sh

# Define o ponto de entrada do contêiner
ENTRYPOINT ["./bin/gatling.sh"]

# Comando padrão para executar uma simulação
CMD ["-sf", "user-files/simulations", "-s", "TicketPurchaseSimulation"]
