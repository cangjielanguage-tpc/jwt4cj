/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.impl

public class PayloadClaimsHolder <: ClaimsHolder {
    public init(claims: Map<String, Any>) {
        super(claims)
    }
}
