/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt4cj

public class SignatureGenerationException <: JWTCreationException {
    public init(algorithmName: String) {
        super("The Token's Signature couldn't be generated when signing using the Algorithm: " + algorithmName)
    }
}
