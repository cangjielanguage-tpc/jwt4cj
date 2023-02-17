// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.impl.*

main(){
//     let jsonStr = ###"{
//   "iss": "issuer1",
//   "sub": "Subject1",
//   "aud": ["Audience1"],
//   "exp": 1673835090,
//   "nbf": 1673830000,
//   "iat": 1673820000,
//   "jti": "jwtid1",
//   "mykey": "myvalue"
// }"###
//     let deser = PayloadDeserializer()
//     let payload = deser.doDeserialize(jsonStr)
//     if(payload.getIssuer() != "issuer1"){
//         return 1
//     }
//     if(payload.getSubject() != "Subject1"){
//         return 2
//     }
//     if(payload.getAudience() != ArrayList(["Audience1"])){
//         return 3
//     }
//     if(payload.getExpiresAt() != Time(1673835090,0)){
//         return 4
//     }
//     if(payload.getNotBefore() != Time(1673830000,0)){
//         return 5
//     }
//     if(payload.getIssuedAt() != Time(1673820000,0)){
//         return 6
//     }
//     if(payload.getId() != "jwtid1"){
//         return 7
//     }
//     if(payload.getClaim("mykey").asString() != "myvalue"){
//         return 8
//     }
//     if(!payload.getClaim("mykey1").isMissing()){
//         return 9
//     }
    0
}
