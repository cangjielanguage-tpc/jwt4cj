package com.itouxin.jwt

import com.itouxin.jwt.interfaces.*
import com.itouxin.jwt.impl.*

public class JWT {

    public static func decode(token: String, secret: String): DecodeJWT {
        return BaseJWT.fromString(token)
    }
    
}