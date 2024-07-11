/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.exception

import jwt.interfaces.*

public class IncorrectClaimException <: InvalidClaimException {
    private var claimName: String
    private var claimValue: Claim

    public init(message: String, claimName: String, claim: Claim) {
        super(message)
        this.claimName = claimName
        this.claimValue = claim
    }

    public func getClaimName(): String {
        return this.claimName
    }

    public func getClaimValue(): Claim {
        return this.claimValue
    }
}
