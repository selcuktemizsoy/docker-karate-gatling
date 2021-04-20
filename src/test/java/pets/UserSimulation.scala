package pets

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef.{Simulation, atOnceUsers, openInjectionProfileFactory, rampUsers, scenario}

import scala.concurrent.duration.DurationInt

class UserSimulation extends Simulation{
  val scenario_name = System.getProperty("scenario")
  val getSingleUser = scenario("simple get").exec(karateFeature("classpath:pets/"+scenario_name+".feature"))
  val postSingleUser = scenario("basic post").exec(karateFeature("classpath:pets/Postfeature.feature@name=post"))
  val protocol = karateProtocol()
  val userCount = System.getProperty("userCount")

  setUp(
    getSingleUser.inject(rampUsers(userCount.toInt) during(10 seconds)).protocols(protocol),
    postSingleUser.inject(rampUsers(10) during(10 seconds)).protocols(protocol)
  )


}
