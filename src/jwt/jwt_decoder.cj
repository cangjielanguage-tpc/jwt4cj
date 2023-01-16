package jwt

import jwt.interfaces.*
import jwt.exception.*
from std import collection.*
from encoding import json.*
from encoding import base64.*
from std import time.*

abstract class JWTDecoder<T> <: DecodedJWT<T> {

    private var parts: Array<String> = Array<String>()

    init(jwt: String) {
        parts = TokenUtils.splitToken(jwt)
        var headerJson: String
        var payloadJson: String
        try {
            headerJson = String.fromUtf8(fromBase64String(parts[0]).getOrThrow())
            payloadJson = String.fromUtf8(fromBase64String(parts[1]).getOrThrow())
        } catch (e: JWTDecodeException) {
            throw JWTDecodeException("The UTF-8 Charset isn't initialized.")
        } catch (e: IllegalArgumentException) {
            throw JWTDecodeException("The input is not a valid base 64 encoded string.")
        }
        
    }

    public func getHeader(): String {
        return parts[0]
    }

    public func getPayload(): String {
        return parts[1]
    }

    public func getSignature(): String {
        return parts[2]
    }

    public func getToken(): String {
        return "${parts[0]}${parts[1]}${parts[2]}"
    }
}
