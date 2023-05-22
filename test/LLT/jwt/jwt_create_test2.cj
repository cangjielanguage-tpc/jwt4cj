// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*

main() {
    if (!f1()) {
        return 1
    }
    if (!f2()) {
        return 2
    }
    if (!f3()) {
        return 3
    }

    0
}
func f1() {
    let map: HashMap<String, Any> = HashMap()
    map.put("any", C())
    try {
        let token = JWT.create().withClaim("map", map).sign(Algorithm.none())
    } catch (e: IllegalArgumentException) {
        return true
    }
    false
}
func f2() {
    let arr: ArrayList<Any> = ArrayList()
    arr.append(C())
    try {
        let token = JWT.create().withClaim("arr", arr).sign(Algorithm.none())
    } catch (e: IllegalArgumentException) {
        return true
    }
    false
}
func f3() {
    let map: HashMap<String, Any> = HashMap()
    map.put("any", C())
    try {
        let token = JWT.create().withPayload(map).sign(Algorithm.none())
    } catch (e: IllegalArgumentException) {
        return true
    }
    false
}
class C {}
