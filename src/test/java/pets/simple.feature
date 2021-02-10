Feature: simple get request
  Background:
    Given url 'https://petstore.swagger.io/v2'

  Scenario: basic
    * path 'pet', 250
    When method GET
    Then status 200
    