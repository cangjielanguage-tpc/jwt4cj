// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.algorithms.*
from jwt import jwt.impl.*
from jwt import jwt.*

main() {
    let map = HashMap<String, Any>()
    let m1: Map<String, Any> = HashMap()
    m1.put("1","11")
    map.put("m1", m1)
    let token = JWT.create().withClaim("map", map).sign(Algorithm.none())
    println(token)
    0
}
