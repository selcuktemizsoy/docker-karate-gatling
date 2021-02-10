package pets

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef.{Simulation, openInjectionProfileFactory, rampUsers, scenario}

import scala.concurrent.duration.DurationInt

class UserSimulation extends Simulation{
  val getSingleUser = scenario("basic").exec(karateFeature("classpath:pets/simple.feature"))

  setUp(
    getSingleUser.inject(rampUsers(100).during(10 seconds))
  )
}
