package jwt.impl.json

from std import collection.ArrayList
from std import collection.Map
from std import collection.collectHashMap
from std import collection.map
import jwt.exception.JWTDecodeException

public open class Deserializer {
    protected func deserialize(jsonStr: String): Map<String, Claim> {
        JsonValue.fromStr(jsonStr).asObject().getFields() |> 
            map {kv: (String, JsonValue) => (kv[0], createClaim(kv[1]))} |>
            collectHashMap
    }

    protected func getStringOrArray(key: String, map: Map<String, Claim>): ?ArrayList<String> {
        let claim = map.get(key)
        match (claim?.getValue()) {
            case Some(v: JsonString) => ArrayList([v.getValue()])
            case Some(_: JsonArray) => asStringList(claim.getOrThrow())
            case None => None
            case _ => throw JWTDecodeException("The claim '${key}' is not string or array.")
        }
    }

    protected func asString(key: String, map: Map<String, Claim>): ?String {
        try {
            map.get(key)?.asString()
        } catch (e: JsonException) {
            throw JWTDecodeException("The claim '${key}' is not string.")
        }
    }

    protected func asTime(key: String, map: Map<String, Claim>): ?DateTime {
        try {
            map.get(key)?.asTime()
        } catch (e: JsonException) {
            throw JWTDecodeException("The claim '${key}' is not time.")
        }
    }
}

public func asIntList(claim: Claim): ArrayList<Int64> {
    claim.asList() |> map {a: JsonValue => a.asInt().getValue()} |> collectArrayList
}

public func asStringList(claim: Claim): ArrayList<String> {
    claim.asList() |> map {a: JsonValue => a.asString().getValue()} |> collectArrayList
}
