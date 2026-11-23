Feature: Grupo 3 - Seguridad de contactos y autenticación

Background:
  * def auth = call read('classpath:grupo3/crear-usuario.feature')
  * def token = auth.token
  * configure afterScenario = function(){ karate.call('classpath:grupo3/eliminar-usuario.feature', { token: karate.get('token') }) }

Scenario: CP-009 - Intentar modificar el identificador interno _id de un contacto mediante PATCH.
  Given url baseUrl
  And path 'contacts'
  And header Authorization = 'Bearer ' + token
  And request { firstName: 'Interno', lastName: 'Original' }
  When method post
  Then status 201
  * def id = response._id
  Given url baseUrl
  And path 'contacts', id
  And header Authorization = 'Bearer ' + token
  And request { _id: 'id-falsificado-123' }
  When method patch
  * def patchStatus = responseStatus
  * print 'CP-009 PATCH HTTP y cuerpo:', patchStatus, response
  * match [200, 400, 403, 422] contains patchStatus
  Given url baseUrl
  And path 'contacts', id
  And header Authorization = 'Bearer ' + token
  When method get
  Then status 200
  And match response._id == id

Scenario: CP-010 - Intentar modificar el propietario owner de un contacto mediante PUT.
  Given url baseUrl
  And path 'contacts'
  And header Authorization = 'Bearer ' + token
  And request { firstName: 'Propietario', lastName: 'Original' }
  When method post
  Then status 201
  * def id = response._id
  * def propietarioOriginal = response.owner
  * def payload = { firstName: 'Propietario', lastName: 'Original', owner: 'propietario-falso-123' }
  Given url baseUrl
  And path 'contacts', id
  And header Authorization = 'Bearer ' + token
  And request payload
  When method put
  * def putStatus = responseStatus
  * print 'CP-010 PUT HTTP y cuerpo:', putStatus, response
  * match [200, 400, 403, 422] contains putStatus
  Given url baseUrl
  And path 'contacts', id
  And header Authorization = 'Bearer ' + token
  When method get
  Then status 200
  And match response.owner == propietarioOriginal

Scenario Outline: CP-013 - Intentar acceder a la lista de contactos utilizando un token de autenticación vacío en la cabecera Authorization.
  Given url baseUrl
  And path 'contacts'
  And header Authorization = '<authorization>'
  When method get
  Then status 401
  * print 'CP-013 HTTP y cuerpo:', responseStatus, response
  Examples:
    | authorization |
    | Bearer        |

Scenario: CP-014 - Intentar cerrar sesión enviando un token de autenticación inválido.
  Given url baseUrl
  And path 'users', 'logout'
  And header Authorization = 'Bearer token-invalido-grupo3'
  When method post
  Then status 401
  * print 'CP-014 HTTP y cuerpo:', responseStatus, response
