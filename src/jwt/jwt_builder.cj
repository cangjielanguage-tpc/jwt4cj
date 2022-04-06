package jwt

from encoding import json.*
from std import serialization.*
from std import collection.*
import jwt.algorithm.*

public class JWTBuilder {

    private var payload: HashMap<String, Object> = HashMap()
    private var header: HashMap<String, Object> = HashMap()


    public func withHeader(header: HashMap<String, Object>): JWTBuilder {
        return this
    }


    public func withAlgorithm(algorithm: String): JWTBuilder {
        return this
    }


    public func withPayload(payload: HashMap<String, Object>): JWTBuilder {
        return this
    }

    public func withIssuer(issuer: String): JWTBuilder {
        return this
    }


    public func withSubject(subject: String): JWTBuilder {
        return this
    }

    public func withAudience(audience: String): JWTBuilder {
        return this
    }

    public func withExpiresAt(expiresAt: UInt64): JWTBuilder {
        return this
    }

    public func withNotBefore(notBefore: UInt64): JWTBuilder {
        return this
    }

    public func withIssuedAt(issuedAt: UInt64): JWTBuilder {
        return this
    }

    public func withJWTId(jwtId: String): JWTBuilder {
        return this
    }

    public func withClaim(name: String, value: JsonValue): JWTBuilder {
        return this
    }

    public func withClaims(claims: HashMap<String, Claim>): JWTBuilder {
        return this
    }


    public func sign(algorithm: Algorithm): JWTBuilder {
        return this
    }
}