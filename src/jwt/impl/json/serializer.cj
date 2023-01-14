package jwt.impl.json

from std import collection.map
import jwt.exception.JWTCreationException

public open class Serializer <: ToString {
    private let data: JsonObject = JsonObject()

    public func put(key: String, value: Any) {
        let jv = parse(value)
        data.put(key, jv)
    }

    public func toString(): String {
        data.toJsonString()
    }
}

let str2jv: (String) -> JsonValue = {value => JsonString(value)}
let bool2jv: (Bool) -> JsonValue = {value => JsonBool(value)}
let int2jv: (Int64) -> JsonValue = {value => JsonInt(value)}
let float2jv: (Float64) -> JsonValue = {value => JsonFloat(value)}
let time2jv: (Time) -> JsonValue = {value => JsonInt(value.unixTimeStamp().seconds())}

let jv2arr = {
    value: JsonValue, arr: JsonArray =>
    arr.add(value)
    arr
}
let jv2obj = {
    kv: (String, JsonValue), obj: JsonObject =>
    obj.put(kv[0], kv[1])
    obj
}

func parse(value: Any): JsonValue {
    return match (value) {
        case value: Bool => bool2jv(value)
        case value: Int64 => int2jv(value)
        case value: Float64 => float2jv(value)
        case value: String => str2jv(value)
        case value: Time => time2jv(value)
        case value: Array<Bool> => value |> map(bool2jv) |> reduce(JsonArray(), jv2arr)
        case value: Array<Int64> => value |> map(int2jv) |> reduce(JsonArray(), jv2arr)
        case value: Array<Float64> => value |> map(float2jv) |> reduce(JsonArray(), jv2arr)
        case value: Array<String> => value |> map(str2jv) |> reduce(JsonArray(), jv2arr)
        case value: Array<Time> => value |> map(time2jv) |> reduce(JsonArray(), jv2arr)
        case value: Array<Any> => value |> map(parse) |> reduce(JsonArray(), jv2arr)
        case value: ArrayList<Bool> => value |> map(bool2jv) |> reduce(JsonArray(), jv2arr)
        case value: ArrayList<Int64> => value |> map(int2jv) |> reduce(JsonArray(), jv2arr)
        case value: ArrayList<Float64> => value |> map(float2jv) |> reduce(JsonArray(), jv2arr)
        case value: ArrayList<String> => value |> map(str2jv) |> reduce(JsonArray(), jv2arr)
        case value: ArrayList<Time> => value |> map(time2jv) |> reduce(JsonArray(), jv2arr)
        case value: ArrayList<Any> => value |> map(parse) |> reduce(JsonArray(), jv2arr)
        case value: Map<String, Any> =>
            value |> map {kv: (String, Any) => (kv[0], parse(kv[1]))}
                |> reduce(JsonObject(), jv2obj)
        case value: JsonValue => value
        case value: Option<Any> => JsonNull()
        case _ => throw JWTCreationException("value type not support")
    }
}
