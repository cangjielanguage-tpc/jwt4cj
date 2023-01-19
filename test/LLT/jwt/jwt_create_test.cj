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
  "kid": "keyId",
  "alg": "none",
  "typ": "JWT"
}
"###

let payload = ###"
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

let token = "ewogICJrMSI6ICJ2MSIsCiAgImtpZCI6ICJrZXlJZCIsCiAgImFsZyI6ICJub25lIiwKICAidHlwIjogIkpXVCIKfQ.ewogICJpc3MiOiAiaXNzdWVyIiwKICAic3ViIjogInN1YmplY3QiLAogICJhdWQiOiBbCiAgICAiYXVkMSIsCiAgICAiYXVkMiIKICBdLAogICJleHAiOiAxNjczODM1MDkwLAogICJuYmYiOiAxNjczODM1MDUwLAogICJpYXQiOiAxNjczODM1MDAwLAogICJqdGkiOiAiand0SWQiLAogICJib29sIjogdHJ1ZSwKICAiaW50NjQiOiA2NCwKICAiZmxvYXQ2NCI6IDMuMTQwMDAwLAogICJTdHJpbmciOiAiYWJhYWJhIiwKICAidGltZSI6IDE2NzM4NTAwMDAsCiAgIm1hcCI6IHsKICAgICJtazIiOiAibXYyIgogIH0sCiAgImxpc3QiOiBbCiAgICA1Ni41MTAwMDAsCiAgICA0MS45NjAwMDAKICBdLAogICJudWxsIjogbnVsbCwKICAiYXJyYXlzdHJpbmciOiBbCiAgICAiYXN0cjEiLAogICAgImFzdHIyIgogIF0sCiAgImFycmF5aW50IjogWwogICAgNjg0LAogICAgNjQKICBdLAogICJwazEiOiAicHYxIiwKICAicGsyIjogInB2MiIKfQ."

main(){
    let jwtStr = JWT.create()
        .withHeader(HashMap<String, Any>([("k1","v1")]))
        .withKeyId("keyId")
        .withIssuer("issuer")
        .withSubject("subject")
        .withAudience(["aud1", "aud2"])
        .withExpiresAt(Time(1673835090,0))
        .withNotBefore(Time(1673835050,0))
        .withIssuedAt(Time(1673835000,0))
        .withJWTId("jwtId")
        .withClaim("bool", true)
        .withClaim("int64", 64)
        .withClaim("float64", 3.14)
        .withClaim("String", "abaaba")
        .withClaim("time", Time(1673850000,0))
        .withClaim("map", HashMap<String, Any>([("mk2","mv2")]))
        .withClaim("list", ArrayList<Any>([56.51,41.96]))
        .withNullClaim("null")
        .withArrayClaim("arraystring", ["astr1","astr2"])
        .withArrayClaim("arrayint", [684,64])
        .withPayload(HashMap<String, Any>([("pk1","pv1"),("pk2","pv2")]))
        .sign(Algorithm.none())
    println(jwtStr)
    println(token)
    if(jwtStr != token){
        return 1
    }
    0
}
