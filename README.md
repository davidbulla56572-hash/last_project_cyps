# 🧪 Proyecto final - Calidad y Pruebas de Software

**Grupo 3 | Universidad de Caldas**

En este proyecto probamos la **Contact List REST API** para revisar cómo responde al crear y actualizar contactos, validar datos y manejar la autenticación.

## ¿Qué hicimos?

- Diseñamos **15 casos de prueba**: positivos, negativos y de seguridad.
- Ejecutamos las pruebas en **Postman** y automatizamos 10 escenarios con **Karate DSL**.
- Organizamos la matriz de resultados, las evidencias y los reportes de hallazgos.

## Resultados

| Herramienta | Resultado |
|---|---|
| **Postman** | 12 aprobados, 1 parcial (CP-008) y 2 fallidos (CP-006 y CP-015) |
| **Karate** | 10 de 10 escenarios aprobados |
| **Python** | 13 aprobados y 2 fallidos según nuestros criterios |

Los hallazgos de **CP-006** (fecha de nacimiento futura) y **CP-015** (cambio del campo `__v`) se explican en el reporte de la Fase 6. Se consideran posibles defectos a revisar; no afirmamos que sean fallos reconocidos oficialmente por la API.

## ¿Cómo ejecutar las pruebas?

1. En **Postman**, importa la colección y su archivo de entorno, selecciona el entorno y usa **Run**.
2. Para **Karate**, abre el proyecto con Java y Maven configurados y ejecuta `mvn test`.
3. Revisa la matriz y las capturas para ver qué ocurrió en cada caso.

## Integrantes

- David Santiago Bulla
- Maria Paz Martinez
- Juan Esteban Ospina

**Asignatura:** Calidad y Pruebas de Software
