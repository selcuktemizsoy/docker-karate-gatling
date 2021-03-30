Feature: simple get request

  Background:
    Given url baseUrl

  Scenario: basic
    * def obj = call read('classpath:pets/PostFeature.feature'){id:10}
    * print obj.response
    * path 'pet'
    * request obj.response
    When method POST
    Then print response

