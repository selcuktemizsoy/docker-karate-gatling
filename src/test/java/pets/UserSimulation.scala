package pets

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef.{Simulation,  constantUsersPerSec, openInjectionProfileFactory,  scenario}

import scala.concurrent.duration.DurationInt

class UserSimulation extends Simulation{

  val getSingleUser = scenario("simple get").exec(karateFeature("classpath:pets/simple.feature"))
  val postSingleUser = scenario("basic post").exec(karateFeature("classpath:pets/Postfeature.feature@name=post"))
  val protocol = karateProtocol()


  setUp(
    getSingleUser.inject(constantUsersPerSec(50) during(20 seconds)).protocols(protocol),
    postSingleUser.inject(constantUsersPerSec(50) during(20 seconds)).protocols(protocol)
  )


}
