/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package cangjie_tpc::jwt4cj

public class SignatureGenerationException <: JWTCreationException {
    public init(algorithmName: String) {
        super("The Token's Signature couldn't be generated when signing using the Algorithm: " + algorithmName)
    }
}
