// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.impl.*

main(){
//     let headerJson = ###"{
//   "alg": "HS256",
//   "typ": "JWT",
//   "cty": "JWT",
//   "kid": "the key for signature validation",
//   "key1": "value1"
// }"###
//     let payloadJson = ###"{
//   "iss": "issuer1",
//   "sub": "Subject1",
//   "aud": ["Audience1"],
//   "exp": 1673835090,
//   "nbf": 1673830000,
//   "iat": 1673820000,
//   "jti": "jwtid1",
//   "key2": "value2"
// }"###

//     let parser = JWTParser()

//     let header = parser.parseHeader(headerJson)
//     if(header.getAlgorithm() != Some("HS256")){
//         return 1
//     }
//     if(header.getType() != Some("JWT")){
//         return 2
//     }
//     if(header.getContentType() != Some("JWT")){
//         return 3
//     }
//     if(header.getKeyId() != Some("the key for signature validation")){
//         return 4
//     }
//     if(header.getHeaderClaim("key1")?.asString() != Some("value1")){
//         return 5
//     }
//     if(header.getHeaderClaim("mykey1")?.asString() != None){
//         return 6
//     }

//     let payload = parser.parsePayload(payloadJson)
//     if(payload.getIssuer() != Some("issuer1")){
//         return 7
//     }
//     if(payload.getSubject() != Some("Subject1")){
//         return 8
//     }
//     if(payload.getAudience() != Some(ArrayList(["Audience1"]))){
//         return 9
//     }
//     if(payload.getExpiresAt() != Some(Time(1673835090,0))){
//         return 10
//     }
//     if(payload.getNotBefore() != Some(Time(1673830000,0))){
//         return 11
//     }
//     if(payload.getIssuedAt() != Some(Time(1673820000,0))){
//         return 12
//     }
//     if(payload.getId() != Some("jwtid1")){
//         return 13
//     }
//     if(payload.getClaim("key2")?.asString() != Some("value2")){
//         return 14
//     }
//     if(payload.getClaim("mykey1")?.asString() != None){
//         return 15
//     }

    0
}