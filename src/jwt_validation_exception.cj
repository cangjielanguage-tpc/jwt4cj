/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package jwt4cj

public open class JWTValidationException <: Exception {
    public init(message: String) {
        super(message)
    }
}
