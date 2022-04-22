package jwt

from encoding import json.*
from encoding import base64.*
from std import serialization.*
from std import collection.*
from std import time.*

import jwt.interfaces.*
import jwt.impl.*
import jwt.common.*
import jwt.exception.*
import jwt.algorithm.*

public class JWTBuilder {

    private var algorithm: Algorithm 
    private var payload: Map<String, JsonValue> = HashMap<String, JsonValue>()
    private var header: Map<String, JsonValue> = HashMap<String, JsonValue>()

    init() {
        this.algorithm = NoneAlgorithm()
    }


    public func withHeader(header: Map<String, Object>): JWTBuilder {
        return this
    }


    public func withAlgorithm(algorithm: Algorithm): JWTBuilder {
        this.algorithm = algorithm
        return this
    }


    public func withPayload(payload: Map<String, Object>): JWTBuilder {
        return this
    }

    public func withIssuer(issuer: String): JWTBuilder {
        this.payload.put(PublicField.ISSUER, JsonString(issuer))
        return this
    }


    public func withSubject(subject: String): JWTBuilder {
        this.payload.put(PublicField.SUBJECT, JsonString(subject))
        return this
    }

    public func withAudience(audience: String): JWTBuilder {
        this.payload.put(PublicField.AUDIENCE, JsonString(audience))
        return this
    }

    /**
     * expiresAt Int64 nanosecond with expiresAt time
     */
    public func withExpiresAt(expiresAt: Int64): JWTBuilder {
        this.payload.put(PublicField.EXPIRES_AT, JsonInt(expiresAt))
        return this
    }

    public func withExpiresAt(expiresAt: Time): JWTBuilder {
        this.payload.put(PublicField.EXPIRES_AT, JsonInt(expiresAt.nanosecond()))
        return this
    }

    public func withNotBefore(notBefore: Int64): JWTBuilder {
        this.payload.put(PublicField.NOT_BEFORE, JsonInt(notBefore))
        return this
    }

    public func withNotBefore(notBefore: Time): JWTBuilder {
        this.payload.put(PublicField.NOT_BEFORE, JsonInt(notBefore.nanosecond()))
        return this
    }

    public func withIssuedAt(issuedAt: Int64): JWTBuilder {
        this.payload.put(PublicField.ISSUED_AT, JsonInt(issuedAt))
        return this
    }

    public func withJWTId(jwtId: String): JWTBuilder {
        this.payload.put(PublicField.ID, JsonString(jwtId))
        return this
    }

    public func withClaim(name: String, value: JsonValue): JWTBuilder {
        this.payload.put(name, value)
        return this
    }

    public func withClaim<T>(name: String, value: T): JWTBuilder {
        let jsonValue = match(value) {
            case v: JsonValue => v
            case v: Int64 => JsonInt(v)
            case v: String => JsonString(v)
            case v: Bool => JsonBool(v)
            case v: Float64 => JsonFloat(v)
            //case v: Array => JsonArray(v)
            case _ => throw JWTEncodeException("Unsupported object type")
        }
        this.payload.put(name, jsonValue)
        return this
    }

    public func withClaims(claims: Map<String, JsonValue>): JWTBuilder {
        this.payload.putAll(claims)
        return this
    }

    public func sign(): DecodeJWT {
        if ("none".equals(this.algorithm.getName())) {
            throw JWTEncodeException("Algorithm cannot be empty")
        }
        header.put(PublicField.ALGORITHM, JsonString(this.algorithm.getName()))
        if (!header.contains(PublicField.TYPE)) {
            header.put(PublicField.TYPE, JsonString("JWT"));
        }

        let headerJson = JsonObject((header as HashMap<String, JsonValue>).getOrThrow()).toJsonString();
        let payloadJson = JsonObject((payload as HashMap<String, JsonValue>).getOrThrow()).toJsonString();

        let headerEncoded = toBase64String(headerJson.toUtf8Array())
        let payloadEncoded = toBase64String(payloadJson.toUtf8Array())
        println("${headerEncoded}.${payloadEncoded}")
        let signature = String.fromUtf8(this.algorithm.sign("${headerEncoded}.${payloadEncoded}".toUtf8Array()))
        return JWT.decode("${headerEncoded}.${payloadEncoded}.${signature}")
    }

    public func sign(algorithm: Algorithm): DecodeJWT {
        this.algorithm = algorithm
        return this.sign()
    }

}