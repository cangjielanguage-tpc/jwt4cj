package jwt.impl

import jwt.impl.json.Serializer

public open class ClaimsSerializer <: Serializer {
    public func serialize(holder: ClaimsHolder): String {
        let claims = holder.getClaims()
        for (kv in claims) {
            put(kv[0], kv[1])
        }
        toString()
    }
}
