Feature: simple get request

  Background:
    Given url baseUrl

  Scenario: basic
    * path 'pet', 250
    When method GET

