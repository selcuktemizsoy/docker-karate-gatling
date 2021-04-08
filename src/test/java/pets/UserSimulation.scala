package pets

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef.{Simulation, constantUsersPerSec, openInjectionProfileFactory, rampUsers, scenario}

import scala.concurrent.duration.DurationInt

class UserSimulation extends Simulation{
  val protocol = {
    karateProtocol()
  }
  val feature = System.getProperty("feature")
  val user = System.getProperty("user")
  val getSingleUser = scenario("simple get").exec(karateFeature("classpath:pets/simple.feature"))
  val postSingleUser = scenario("basic post").exec(karateFeature("classpath:pets/" + feature))
 /* val protocol = karateProtocol(

    "/pets" -> pauseFor("get" -> 0, "post" -> 0)
  */
  setUp(
  //  getSingleUser.inject(rampUsers(5) during(10 seconds))//.protocols(protocol)
    postSingleUser.inject(rampUsers(user.toInt) during(2 seconds),
      constantUsersPerSec(user.toInt) during(4 seconds)).protocols(protocol)
  )


}
