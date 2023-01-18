package jwt

import jwt.algorithms.Algorithm
import jwt.impl.JWTParser
import jwt.interfaces.DecodedJWT

public class JWT {
    private let parser: JWTParser

    public init() {
        this.parser = JWTParser()
    }

    // public func decode(token:String): DecodedJWT {}
    
    // public static func decode(token:String): DecodedJWT{}
    
    // public static func require(algorithm:Algorithm): Verification{}
    
    /*
     * Returns a Json Web Token builder used to create and sign tokens.
     *
     * @return a token builder.
     */
    public static func create(): Builder {
        JWTCreator.builder()
    }
}
