
Feature: Grupo 3 - Casos positivos de contactos CP-001 a CP-005

Background:
  # Crear usuario temporal y obtener token
  * def auth = call read('classpath:grupo3/crear-usuario.feature')
  * def token = auth.token

  # CORRECCION: aplicar Authorization a todas las solicitudes
  * configure headers = { Authorization: '#("Bearer " + token)' }

  # Eliminar usuario temporal al finalizar cada escenario
  * configure afterScenario = function(){ karate.call('classpath:grupo3/eliminar-usuario.feature', { token: karate.get('token') }) }

  # Generar identificador aleatorio para datos de prueba
  * def UUID = Java.type('java.util.UUID')
  * def sufijo = UUID.randomUUID().toString().substring(0, 8)


Scenario: CP-001 - Crear un contacto utilizando caracteres especiales y tildes en el nombre y apellido.
  * def payload = { firstName: 'María-José', lastName: 'Muñoz Peña', email: '#("c001-" + sufijo + "@example.com")' }

  Given url baseUrl
  And path 'contacts'
  And request payload
  When method post
  Then status 201
  And match response contains { firstName: 'María-José', lastName: 'Muñoz Peña', _id: '#string' }

  * print 'CP-001 respuesta completa:', response


Scenario: CP-002 - Crear un contacto omitiendo todos los campos opcionales y enviando únicamente los datos mínimos requeridos.
  # Hipotesis: firstName y lastName son suficientes.
  # Esta regla no esta confirmada por la documentacion.

  * def payload = { firstName: 'Minimo', lastName: 'GrupoTres' }

  Given url baseUrl
  And path 'contacts'
  And request payload
  When method post

  * print 'CP-002 HTTP y respuesta:', responseStatus, response

  Then status 201
  And match response contains { firstName: 'Minimo', lastName: 'GrupoTres', _id: '#string' }


Scenario: CP-003 - Actualizar parcialmente varios campos de un contacto en una sola petición PATCH.
  # Crear contacto inicial

  Given url baseUrl
  And path 'contacts'
  And request { firstName: 'Inicial', lastName: 'Apellido', city: 'Pereira', phone: '3001234567' }
  When method post
  Then status 201

  * def id = response._id

  # Actualizar varios campos con PATCH

  Given url baseUrl
  And path 'contacts', id
  And request { firstName: 'Actualizado', city: 'Manizales', phone: '3109876543' }
  When method patch
  Then status 200

  And match response contains { firstName: 'Actualizado', city: 'Manizales', phone: '3109876543', lastName: 'Apellido' }

  * print 'CP-003 respuesta PATCH:', response


Scenario: CP-004 - Verificar que al crear varios contactos consecutivamente, cada uno recibe un identificador único y diferente.
  # Crear primer contacto

  Given url baseUrl
  And path 'contacts'
  And request { firstName: 'Primero', lastName: 'GrupoTres' }
  When method post
  Then status 201
  And match response contains { _id: '#string' }

  * def id1 = response._id

  # Crear segundo contacto

  Given url baseUrl
  And path 'contacts'
  And request { firstName: 'Segundo', lastName: 'GrupoTres' }
  When method post
  Then status 201
  And match response contains { _id: '#string' }

  * def id2 = response._id

  # Crear tercer contacto

  Given url baseUrl
  And path 'contacts'
  And request { firstName: 'Tercero', lastName: 'GrupoTres' }
  When method post
  Then status 201
  And match response contains { _id: '#string' }

  * def id3 = response._id

  # Validar que los tres identificadores sean diferentes

  * match id1 != id2
  * match id1 != id3
  * match id2 != id3

  * print 'CP-004 IDs distintos:', id1, id2, id3


Scenario: CP-005 - Crear dos contactos diferentes utilizando el mismo número telefónico.
  # La documentacion no confirma si el telefono debe ser unico.
  # Se verifica la hipotesis de aceptacion.

  * def telefono = '3005557788'

  # Crear primer contacto

  Given url baseUrl
  And path 'contacts'
  And request { firstName: 'PersonaUno', lastName: 'Prueba', phone: '#(telefono)' }
  When method post
  Then status 201

  * def id1 = response._id

  # Crear segundo contacto con el mismo telefono

  Given url baseUrl
  And path 'contacts'
  And request { firstName: 'PersonaDos', lastName: 'Prueba', phone: '#(telefono)' }
  When method post

  * print 'CP-005 segunda creacion HTTP y cuerpo:', responseStatus, response

  Then status 201
  And match response contains { phone: '#(telefono)', _id: '#string' }

  # Comprobar que ambos contactos tengan IDs diferentes

  * match response._id != id1
