Feature: it is for creating pet in the API

  Background: 
    Given url baseUrl
  @name=post
  Scenario: post the pets
    * def pet = read('classpath:data/data.json')
    * set pet.id = 250
    * request pet
    * print result
    * path 'pet'
    When method POST

    Scenario Outline: js functions example
      * print email
      Examples:
        | i => i > 2 ?  : ({email: `test_${i}@user.com`}) |

