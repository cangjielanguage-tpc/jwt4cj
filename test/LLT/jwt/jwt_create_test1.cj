// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
internal import std.collection.*
internal import std.time.*
internal import encoding.json.*
internal import jwt4cj.*

main() {
    let timeArr: ArrayList<Any> = ArrayList()
    timeArr.append(DateTime.ofEpoch(second: 1673850000, nanosecond: 0))
    let boolArr: ArrayList<Any> = ArrayList()
    boolArr.append(true)
    let anyArr: ArrayList<Any> = ArrayList()
    anyArr.append(1)
    anyArr.append("q")
    anyArr.append(DateTime.ofEpoch(second: 1673850890, nanosecond: 0))
    anyArr.append(false)
    anyArr.append(3.14)
    let token = 
        JWT.create().withClaim("timeArray", timeArr).withClaim("boolArray", boolArr).withClaim("anyArr", anyArr).sign(
        Algorithm.none())
    println(token)
    0
}
