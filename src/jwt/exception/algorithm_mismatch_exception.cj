/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.exception

public class AlgorithmMismatchException <: JWTVerificationException {
    public init(message: String) {
        super(message)
    }
}
