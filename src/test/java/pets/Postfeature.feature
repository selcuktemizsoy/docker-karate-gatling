Feature: it is for creating pet in the API

  Background: 
    Given url baseUrl
  @name=post
  Scenario: post the pets
    * def pet = read('classpath:data/data.json')
    * request pet
    * path 'pet'
    When method POST
    * print response
    Then status 200