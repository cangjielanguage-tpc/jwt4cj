package com.itouxin.jwt.exception

public class JWTDecodeException <: RuntimeException {
    public JWTDecodeException(message: String) {
        super(message);
    }
}