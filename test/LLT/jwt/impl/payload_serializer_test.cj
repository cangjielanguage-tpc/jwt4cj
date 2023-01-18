// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.impl.*

main(){
    let map = HashMap<String, Any>()
    map.put("String", "String1")
    map.put("Bool", true)
    map.put("Int64", 64)
    map.put("Float64", 3.14)
    map.put("Time", Time(1673820000,0))
    map.put("Array", JsonValue.fromStr("[true]"))
    map.put("Object", JsonValue.fromStr(##"{"k":"v"}"##))

    let res = ###"{
  "String": "String1",
  "Bool": true,
  "Int64": 64,
  "Float64": 3.140000,
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
