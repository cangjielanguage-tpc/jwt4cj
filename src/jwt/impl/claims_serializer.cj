/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.impl

import jwt.impl.json.Serializer

public open class ClaimsSerializer <: Serializer {
    public func serialize(holder: ClaimsHolder): String {
        let claims = holder.getClaims()
        for ((key, value) in claims) {
            put(key, value)
        }
        toString()
    }
}
