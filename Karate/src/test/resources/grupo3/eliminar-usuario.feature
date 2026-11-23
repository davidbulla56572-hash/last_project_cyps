@ignore
Feature: Limpieza de usuario temporal

Scenario: Intentar eliminar la cuenta creada por el escenario
  Given url baseUrl
  And path 'users', 'me'
  And header Authorization = 'Bearer ' + token
  When method delete
  # Limpieza de mejor esfuerzo: guardar el resultado en el reporte.
  * print 'LIMPIEZA usuario temporal: HTTP', responseStatus
