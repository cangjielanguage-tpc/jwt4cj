// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.algorithms.*
from jwt import jwt.impl.*
from jwt import jwt.*

let header = ###"
{
  "k1": "v1",
  "kid": "algorithm.getSigningKeyId()",
  "alg": "none",
  "typ": "JWT",
  "cty": "JWT"
}
"###

let payload = 
    ###"
{
  "iss": "issuer",
  "sub": "subject",
  "aud": [
    "aud1",
    "aud2"
  ],
  "exp": 1673835090,
  "nbf": 1673835050,
  "iat": 1673835000,
  "jti": "jwtId",
  "bool": true,
  "int64": 64,
  "float64": 3.14,
  "String": "abaaba",
  "time": 1673850000,
  "map": {
    "mk2": "mv2"
  },
  "list": [
    56.51,
    41.96
  ],
  "null": null,
  "arraystring": [
    "astr1",
    "astr2"
  ],
  "arrayint": [
    684,
    64
  ],
  "pk1": "pv1",
  "pk2": "pv2"
}
"###

let token = 
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhcnJheSI6WzEsMiwzXSwiZXhwIjoxNjc3MDM1ODYwLCJ1c2VySWQiOjEyMywidXNlcmlkIjoiMjIyIiwidXNlcm5hbWUiOiJ4aWFvbWluZyJ9.AGlXD_w6uV96BII6Sn8xOWXEuxVHesQJy9QCrCKfJsE";

main() {

  let require = JWT.require(Algorithm.HMAC256("admin"));
  try {
    require.withClaim("username","xiaoming")
    require.build().verify(token);
    return 0
  } catch(e: Exception) {
    return 1
  }
  0
}
