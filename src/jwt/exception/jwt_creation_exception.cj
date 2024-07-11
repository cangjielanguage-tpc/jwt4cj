/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.exception

public open class JWTCreationException <: Exception {
    public init(message: String) {
        super(message)
    }
}
