// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from encoding import json.*
from jwt import jwt.impl.*

main(){
    let jsonStr = ###"{
  "alg": "HS256",
  "typ": "JWT",
  "cty": "JWT",
  "kid": "the key for signature validation",
  "mykey": "myvalue"
}"###
    let deser = HeaderDeserializer()
    let header = deser.doDeserialize(jsonStr)
    if(header.getAlgorithm() != "HS256"){
        return 1
    }
    if(header.getType() != "JWT"){
        return 2
    }
    if(header.getContentType() != "JWT"){
        return 3
    }
    if(header.getKeyId() != "the key for signature validation"){
        return 4
    }
    if(header.getHeaderClaim("mykey").asString() != "myvalue"){
        return 5
    }
    if(!header.getHeaderClaim("mykey1").isMissing()){
        return 6
    }
    0
}