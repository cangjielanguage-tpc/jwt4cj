package jwt.impl.json

from std import collection.*

public open class Deserializer {
    protected func deserialize(jsonStr: String): HashMap<String, Claim> {
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
}
