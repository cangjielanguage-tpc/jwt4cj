package jwt.impl

import jwt.common.RegisteredClaims
import jwt.interfaces.Payload
import jwt.impl.json.Deserializer
import jwt.impl.json.getStringOrArray

public class PayloadDeserializer <: Deserializer {
    public func doDeserialize(jsonStr: String): Payload {
        let map = super.deserialize(jsonStr)
        let issuer: ?String = map.get(RegisteredClaims.ISSUER)?.asString()
        let subject: ?String = map.get(RegisteredClaims.SUBJECT)?.asString()
        let audience: ?ArrayList<String> = getStringOrArray(RegisteredClaims.AUDIENCE, map)
        let expiresAt: ?Time = map.get(RegisteredClaims.EXPIRES_AT)?.asTime()
        let notBefore: ?Time = map.get(RegisteredClaims.NOT_BEFORE)?.asTime()
        let issuedAt: ?Time = map.get(RegisteredClaims.ISSUED_AT)?.asTime()
        let jwtId: ?String = map.get(RegisteredClaims.JWT_ID)?.asString()
        BasePayload(issuer, subject, audience, expiresAt, notBefore, issuedAt, jwtId, map)
    }
}
