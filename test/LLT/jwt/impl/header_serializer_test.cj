// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
internal import std.collection.*
internal import encoding.json.*
internal import jwt4cj.*

main(){
    let map = HashMap<String, Any>()
    map.put("String", "String1")
    map.put("Bool", true)
    map.put("Int64", 64)
    map.put("Float64", 3.14)
    map.put("Array", JsonValue.fromStr("[]"))
    map.put("Object", JsonValue.fromStr("{}"))

    let res = ###"{
  "String": "String1",
  "Bool": true,
  "Int64": 64,
  "Float64": 3.14,
  "Array": [],
  "Object": {}
}"###
    let ser = HeaderSerializer()
    let str = ser.serialize(HeaderClaimsHolder(map))
    if(str != res){
        return 1
    }
    0
}