<h1>Introduction</h1>

This is base Karate-Gatling performance testing suite. 

<h2>Environment</h2>

* IntelliJ IDE

* Installed Java at least 8

* Scala latest version

* Karate and gatling dependency


<h2>Installation</h2>

1. Install Java at least version 8

2. Install IntelliJ (community version is enough)

3. Create new Maven project

4. Open pom.xml file and add below dependency

    ```
        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-apache</artifactId>
            <version>0.9.5</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-gatling</artifactId>
            <version>0.9.5</version>
            <scope>test</scope>
        </dependency>

   ```
   
5. Add test resources inside of the build
    
    ```
    <testResources>
        <testResource>
              <directory>src/test/java</directory>
                  <excludes>
                      <exclude>**/*.java</exclude>
                  </excludes>
        </testResource>
    </testResources>
    ```
6. Add gatling plugin inside of the build. Adjust the simulation class after creating class. It is not must, if you do not want to invoke
your performance testing class you can remove executions phase. 
    
    ```
            <plugins>
                <plugin>
                    <groupId>io.gatling</groupId>
                    <artifactId>gatling-maven-plugin</artifactId>
                    <version>3.0.1</version>
                    <configuration>
                        <simulationsFolder>src/test/java</simulationsFolder>
                        <includes>
                            <include>package.simulationClassName</include>
                        </includes>
                    </configuration>
                    <executions>
                        <execution>
                            <phase>test</phase>
                            <goals>
                                <goal>test</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
    ```   

7. Sync pom.xml

8. Add scala plugin to your IDE

9. Right Click project name and add framework support, choose scala and select latest version

10. Create your package structure like that. 

    ```
    -src
        -test
            -java
                *karate-config.js
                *some-reusable.feature
                -data(for providing data, json, csv etc)
                -features
                    *UserSimulation
                    -somefeaturefile.feature
   
    ```

11. Create your scenarios that you want to run

12. Under the features create new scala class name is UserSimulation or anyother thing
 
13. Extends simulation class and define required variables. You can define protocols as required. For more info refer this https://github.com/intuit/karate/tree/master/karate-gatling#karateprotocol

    ```Scala
    class UserSimulation extends Simulation{
      
    val getSingleUser = scenario("simple get").exec(karateFeature("classpath:pets/simple.feature"))
    val protocol = karateProtocol(
        "/pets" -> pauseFor("get" -> 0, "post" -> 0)
    )
      setUp(
        getSingleUser.inject(rampUsers(50) during(10 seconds)).protocols(protocol)
      )
    }
    ```

14. Run your code with `mvn test` if you have added execution phases. 
If not you can run your test with this command 

`mvn clean test-compile gatling:test`

