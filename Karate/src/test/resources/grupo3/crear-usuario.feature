@ignore
Feature: Preparar cuenta de pruebas y token reutilizable

Scenario: Crear usuario temporal
  * def UUID = Java.type('java.util.UUID')
  * def emailPrueba = 'grupo3-' + UUID.randomUUID() + '@example.com'
  * def usuario = { firstName: 'Grupo', lastName: 'Tres', email: '#(emailPrueba)', password: 'PruebaTemporal123!' }
  Given url baseUrl
  And path 'users'
  And request usuario
  When method post
  Then status 201
  And match response contains { token: '#string' }
  * def token = response.token
