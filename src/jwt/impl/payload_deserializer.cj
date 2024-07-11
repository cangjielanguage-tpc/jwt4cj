/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.impl

import jwt.common.RegisteredClaims
import jwt.interfaces.Payload
import jwt.impl.json.Deserializer

public class PayloadDeserializer <: Deserializer {
    func doDeserialize(jsonStr: String): Payload {
        let map = super.deserialize(jsonStr)
        let issuer: ?String = asString(RegisteredClaims.ISSUER, map)
        let subject: ?String = asString(RegisteredClaims.SUBJECT, map)
        let audience: ?ArrayList<String> = getStringOrArray(RegisteredClaims.AUDIENCE, map)
        let expiresAt: ?DateTime = asTime(RegisteredClaims.EXPIRES_AT, map)
        let notBefore: ?DateTime = asTime(RegisteredClaims.NOT_BEFORE, map)
        let issuedAt: ?DateTime = asTime(RegisteredClaims.ISSUED_AT, map)
        let jwtId: ?String = asString(RegisteredClaims.JWT_ID, map)
        BasePayload(issuer, subject, audience, expiresAt, notBefore, issuedAt, jwtId, map)
    }
}
