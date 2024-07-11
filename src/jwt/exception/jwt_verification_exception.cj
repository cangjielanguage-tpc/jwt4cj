/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2023. All rights resvered.
 */
package jwt.exception

/*
 * Parent to all the exception thrown while verifying a JWT.
 */
public open class JWTVerificationException <: Exception {
    public init(message: String) {
        super(message)
    }
}
