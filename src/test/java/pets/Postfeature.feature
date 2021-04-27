Feature: it is for creating pet in the API

  Background: 
    Given url baseUrl
  @name=post
  Scenario: post the pets
    * def pet = read('classpath:data/data.json')
    * set pet.id = 250
    * request pet
    * path 'pet'
    When method POST
    Then status 200



