// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*

main(){
    let jwtStr = JWT.create()
        .withClaim("JsonInt", JsonInt(11))
        .withClaim("JsonBool", JsonBool(true))
        .withClaim("JsonFloat", JsonFloat(1.1))
        .withClaim("JsonString", JsonString("str"))
        .withClaim("JsonArray", JsonArray([JsonString("str"), JsonInt(11), JsonFloat(1.1)]))
        .withClaim("JsonObject", JsonObject(HashMap<String, JsonValue>([("k1", JsonString("v1"))])))
        .sign(Algorithm.none())
    println(jwtStr)

    let map = JWTDecoder(jwtStr).getClaims()
    for ((k,v) in map) {
        println("${k}: ${v}")
    }
    0
}
