Feature: simple get request
  Background:
    Given url baseUrl

  Scenario: basic
    * path 'pet', 250
    When method GET
    Then status 200
    Then match response.id == 250

