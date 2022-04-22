package jwt

import jwt.interfaces.*
import jwt.algorithm.*
import jwt.impl.*

public class JWT {

    public static func decode(token: String): DecodeJWT {
        return BaseJWT.fromString(token)
    }


    public static func verify(token: String, algorithm: Algorithm): Unit {
       return verify(decode(token), algorithm)
    }


    public static func verify(jwt: DecodeJWT, algorithm: Algorithm): Unit {
        return JWTValidator(jwt).verify(algorithm)
    }


    public static func builder(): JWTBuilder {
        return JWTBuilder()
    }
    
}