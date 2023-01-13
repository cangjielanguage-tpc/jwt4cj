package jwt.impl.json

from encoding import json.JsonObject

public open class Deserializer {
    public func deserialize(jsonStr: String): HashMap<String, Claim> {
        let data = JsonValue.fromStr(jsonStr).asObject()
        let valueMap = data.getFields()
        valueMap
        HashMap<String, Claim>()
    }
}
