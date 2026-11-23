Feature: Grupo 3 - Validación de datos en registro de usuarios

Scenario: CP-012 - Intentar registrar un usuario enviando un valor numérico en el atributo email en lugar de una cadena de texto.
  # Hipótesis: la API rechaza el tipo numérico; documentar cualquier comportamiento distinto.
  * def UUID = Java.type('java.util.UUID')
  * def payload = { firstName: 'Dato', lastName: 'Invalido', email: 123456789, password: 'PruebaTemporal123!' }
  Given url baseUrl
  And path 'users'
  And request payload
  When method post
  * print 'CP-012 HTTP y cuerpo:', responseStatus, response
  Then status 400
  And match response == '#object'
