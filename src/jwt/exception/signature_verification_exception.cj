/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.exception

public class SignatureVerificationException <: JWTVerificationException {
    public init(algorithmName: String) {
        super("The Token's Signature resulted invalid when verified using the Algorithm: " + algorithmName)
    }
}
