// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*

main() {
    let map = HashMap<String, Any>()

    // let m1: Map<String, Any> = HashMap()
    // m1.put("1", "11")
    // map.put("m1", m1)
    let nullNode: JsonValue = JsonNull()
    let a2 = ArrayList<Any>(["asd", true, 1, 3.14, DateTime.ofEpoch(second: 1673835090, nanosecond: 0), nullNode, JsonValue.fromStr(##""jsonstring""##)]
    )
    map.put("a2", a2)
    map.put("", nullNode)
    let token = JWT.create().withClaim("map", map).sign(Algorithm.none())
    println(token)
    0
}
