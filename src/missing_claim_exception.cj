/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package cangjie_tpc::jwt4cj

public open class MissingClaimException <: InvalidClaimException {
    private var claimName: String

    public init() {
        super("The Claim is not present in the JWT.")
        this.claimName = ""
    }

    public init(claimName: String) {
        super("The Claim '${claimName}' is not present in the JWT.")
        this.claimName = claimName
    }

    public func getClaimName(): String {
        return this.claimName
    }
}
