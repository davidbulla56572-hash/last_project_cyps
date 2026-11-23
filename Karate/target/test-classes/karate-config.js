function fn() {
  var config = {};
  config.baseUrl = karate.properties['baseUrl'] || 'https://thinking-tester-contact-list.herokuapp.com';
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 25000);
  // Los tokens se usan en memoria y NO deben publicarse en capturas ni repositorios.
  return config;
}
