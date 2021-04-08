function fn() {
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
    appId: 'my.app.id',
    appSecret: 'my.secret',
    baseUrl: 'https://petstore.swagger.io/v2',
    anotherUrlBase: 'https://another-host.com/v1/'

  };
  if (env == 'stage') {
    // over-ride only those that need to be
    config.baseUrl = 'https://stage-host/v1/auth';
  } else if (env == 'e2e') {
    config.baseUrl = 'https://e2e-host/v1/auth';
  }
  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
 var result = karate.callSingle('classpath:pets/simple.feature',config);
  var result2 = karate.callSingle('classpath:pets/simple.feature',config);


  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}