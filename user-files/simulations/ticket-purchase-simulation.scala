import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class TicketPurchaseSimulation extends Simulation {

  val httpProtocol = http
    .baseUrl("https://www.blazedemo.com")
    .inferHtmlResources()
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .userAgentHeader("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")

  val scn = scenario("Comprar Passagem Aérea com Sucesso")
    .exec(
      http("Home Page")
        .get("/")
        .check(status.is(200))
    )
    .pause(1)
    .exec(
      http("Selecionar Voo")
        .post("/reserve.php")
        .formParam("fromPort", "Boston")
        .formParam("toPort", "London")
        .check(status.is(200))
    )
    .pause(1)
    .exec(
      http("Comprar Passagem")
        .post("/purchase.php")
        .formParam("inputName", "Carlos Bonfatti")
        .formParam("address", "Rua araras, 123")
        .formParam("city", "Cidade São Paulo")
        .formParam("state", "São Paulo")
        .formParam("zipCode", "12345")
        .formParam("cardType", "Visa")
        .formParam("creditCardNumber", "1234567890123456")
        .formParam("creditCardMonth", "12")
        .formParam("creditCardYear", "2024")
        .formParam("nameOnCard", "Carlos Bonfatti")
        .check(status.is(200)) 
        .check(regex("Thank you for your purchase!").exists)
    )

  setUp(
    scn.inject(
      rampUsersPerSec(10).to(250).during(30.seconds),
      constantUsersPerSec(250).during(30.seconds)
    ).protocols(httpProtocol)
  ).assertions(
    global.responseTime.percentile(90).lt(2000),
    global.successfulRequests.percent.is(100)
  )
}
