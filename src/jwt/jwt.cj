package jwt

import jwt.interfaces.*
import jwt.impl.*

public class JWT {

    public static func decode(token: String): DecodeJWT {
        return BaseJWT.fromString(token)
    }


    public static func verify(token: String): DecodeJWT {
        return BaseJWT.fromString(token)
    }


    public static func verify(jwt: DecodeJWT): DecodeJWT {
        return jwt
    }
    
}