Feature: it is for creating pet in the API

  Background: 
    Given url baseUrl
  @post
  Scenario: post the pets
    * def pet = read('classpath:data/data.json')
    * set pet.id = 250
    * request pet
    * path 'pet'
    When method POST

    Scenario Outline: js functions example
      * print email
      Examples:
        | i => i > 2 ?  : ({email: `test_${i}@user.com`}) |

