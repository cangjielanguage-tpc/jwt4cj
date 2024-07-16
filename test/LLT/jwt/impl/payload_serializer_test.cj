// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
internal import std.collection.*
internal import std.time.*
internal import encoding.json.*
internal import jwt4cj.*

main(){
    let map = HashMap<String, Any>()
    map.put("String", "String1")
    map.put("Bool", true)
    map.put("Int64", 64)
    map.put("Float64", 3.14)
    map.put("Time", DateTime.ofEpoch(second: 1673820000, nanosecond: 0))
    map.put("Array", JsonValue.fromStr("[true]"))
    map.put("Object", JsonValue.fromStr(##"{"k":"v"}"##))

    let res = ###"{
  "String": "String1",
  "Bool": true,
  "Int64": 64,
  "Float64": 3.14,
  "Time": 1673820000,
  "Array": [
    true
  ],
  "Object": {
    "k": "v"
  }
}"###
    let ser = PayloadSerializer()
    let str = ser.serialize(PayloadClaimsHolder(map))
    if(str != res){
        println(str)
        
        return 1
    }
    0
}
