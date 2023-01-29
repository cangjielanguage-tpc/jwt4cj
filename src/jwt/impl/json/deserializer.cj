package jwt.impl.json

from std import collection.ArrayList
from std import collection.Map
from std import collection.collectArrayList
from std import collection.collectHashMap
from std import collection.map
import jwt.exception.JWTDecodeException

public open class Deserializer {
    protected func deserialize(jsonStr: String): Map<String, Claim> {
        JsonValue.fromStr(jsonStr).asObject().getFields()
            |> map {kv: (String, JsonValue) => (kv[0], createClaim(kv[1]))}
            |> collectHashMap
    }

}

public func asIntList(claim: ?Claim): ?ArrayList<Int64> {
    match (claim) {
        case Some(v) => v.asList() |> map {a: JsonValue => a.asInt().getValue()} |> collectArrayList
        case _ => None
    }
}

public func asFloatList(claim: ?Claim): ?ArrayList<Float64> {
    match (claim) {
        case Some(v) => v.asList() |> map {a: JsonValue => a.asFloat().getValue()} |> collectArrayList
        case _ => None
    }
}

public func asStringList(claim: ?Claim): ?ArrayList<String> {
    match (claim) {
        case Some(v) => v.asList() |> map {a: JsonValue => a.asString().getValue()} |> collectArrayList
        case _ => None
    }
}

public func getStringOrArray(key: String, map: Map<String, Claim>): ?ArrayList<String> {
    let claim = map.get(key)
    match (claim?.getValue()) {
        case Some(v:JsonString) => Some(ArrayList([v.getValue()]))
        case Some(v:JsonArray) => asStringList(claim)
        case None => None
        case _ => throw JWTDecodeException("The claim '${key}' is not string or array.")
    }
}
