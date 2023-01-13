package jwt.impl.json

from std import collection.HashMap
from encoding import json.JsonObject
from encoding import json.JsonValue
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

func parse(value: Any): JsonValue {
    return match (value) {
        case value: Bool => JsonBool((value as Bool).getOrThrow())
        case value: Int64 => JsonInt((value as Int64).getOrThrow())
        case value: Float64 => JsonFloat((value as Float64).getOrThrow())
        case value: String => JsonString((value as String).getOrThrow())
        case value: JsonValue => value
        case _ => throw JWTCreationException("value type not support")
    }
}
