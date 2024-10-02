# Teste de Performance de Compra de Passagem Aérea

## Descrição
Este projeto foi desenvolvido para realizar testes de performance no processo de compra de passagens aéreas utilizando o **Gatling**. O site alvo dos testes é o [BlazeDemo](https://www.blazedemo.com), um exemplo de site de vendas de passagens. O objetivo é avaliar a escalabilidade do sistema sob carga, garantindo que ele atenda a uma taxa de 250 requisições por segundo com um percentil de 90% do tempo de resposta abaixo de 2 segundos.

## Autor
**Carlos Bonfatti**  
MBA em Data Science & AI  
Especialista em Qualidade de Software, Automação e Performance

## Como Executar

### Requisitos
- Docker instalado na máquina (você pode baixar o Docker [aqui](https://www.docker.com/get-started))

### Passos para Execução

1. **Clone o repositório**
   Primeiro, clone o repositório para o seu ambiente local:
   ```bash
   git clone <url-do-repositorio>
   cd test-performance-compra-de-passagens
2. **Construa a imagem Docker**  
   Para evitar a instalação manual do Gatling, utilizamos Docker para criar um ambiente isolado. O comando abaixo irá construir a imagem Docker com tudo o que você precisa:

   ```bash
   docker build -t gatling-simulation .

3. **Execute o container com Gatling**  
   Após construir a imagem, execute o container que iniciará o Gatling, mapeando o diretório de resultados:

   ```bash
   echo "1" | docker run --rm -i -v $(pwd)/gatling-results:/opt/gatling/gatling/results gatling-simulation 
   

4. **Acesse o relatório de performance**  
   Após a execução, o Gatling gera um relatório de performance detalhado. Para abrir o relatório no seu navegador, execute o seguinte comando:
   exemplo:

   ```bash
   open gatling-results/ticketpurchasesimulation-20241002174031544/index.html

## Estrutura do Projeto

- **Dockerfile:** Configura o ambiente Docker com o Gatling.
- **Simulações:** Contém os scripts de simulação escritos em Scala para o teste de performance.

## Metodologia

Este projeto adota a abordagem **Shift-Left Testing**, integrando testes de performance desde as fases iniciais do ciclo de desenvolvimento. Essa estratégia permite a identificação e correção de problemas de forma antecipada, resultando em um produto final de maior qualidade.

Os critérios de aceitação para os testes foram definidos com base em dois parâmetros principais:

- **Taxa de Requisições:** 250 requisições por segundo.
- **Tempo de Resposta:** 90% das requisições devem ter um tempo de resposta inferior a 2 segundos.

Esses critérios visam assegurar a alta disponibilidade e confiabilidade do sistema em ambientes de produção, garantindo que ele possa suportar a carga esperada durante períodos de pico de uso.


## Referências
- [Documentação oficial do Gatling](https://gatling.io/docs/current/)