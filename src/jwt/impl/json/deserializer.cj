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

    protected func asStringList(claim: ?Claim): Option<ArrayList<String>> {
        match (claim) {
            case Some(v) => v.asList() |> map {a: JsonValue => a.toStr()} |> collectArrayList
            case _ => None
        }
    }

    protected func getStringOrArray(key: String, map: Map<String, Claim>): ?ArrayList<String> {
        let claim = map.get(key)
        match (claim) {
            case Some(v) =>
                match (v.getValue().kind()) {
                    case JsString => Some(ArrayList<String>([v.asString()]))
                    case JsArray => asStringList(claim)
                    case _ => throw JWTDecodeException("The claim '${key}' is not string or array.")
                }
            case _ => None
        }
    }
}
