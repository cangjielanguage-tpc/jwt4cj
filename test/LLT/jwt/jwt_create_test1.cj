// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*

main() {
    let timeArr: ArrayList<Any> = ArrayList()
    timeArr.append(Time(1673850000, 0))
    let boolArr: ArrayList<Any> = ArrayList()
    boolArr.append(true)
    let anyArr: ArrayList<Any> = ArrayList()
    anyArr.append(1)
    anyArr.append("q")
    anyArr.append(Time(1673850890, 0))
    anyArr.append(false)
    anyArr.append(3.14)
    let token = 
        JWT.create().withClaim("timeArray", timeArr).withClaim("boolArray", boolArr).withClaim("anyArr", anyArr).sign(
        Algorithm.none())
    println(token)
    0
}
