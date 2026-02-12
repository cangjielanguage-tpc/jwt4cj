/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package cangjie_tpc::jwt4cj

public class AlgorithmMismatchException <: JWTVerificationException {
    public init(message: String) {
        super(message)
    }
}
