package jwt.impl

import jwt.interfaces.*
import jwt.exception.*

public class BaseJWT <: DecodeJWT & Header & Payload {

    private var parts: String * String * String
    private var header: Header
    private var payload: Payload

    public init(parts: String * String * String) {
        this.parts = parts
        try {
            this.header = JWTParser.parseHeader(parts[0])
            this.payload = JWTParser.parsePayload(parts[1])
        } catch (e: Exception) {
            e.printStackTrace()
            throw e
        }
    }

    public static func fromString(jwt: String) {
        let parts: Array<String> = jwt.split('.')
        if (parts.size() != 3) {
            throw JWTDecodeException("The token was expected to have 3 parts, but got ${parts.size()}.")
        }
        return BaseJWT((parts[0], parts[1], parts[2]))
    }

    
    public func getHeader(): String {
        return this.parts[0]
    }

    public func getPayload(): String {
        return this.parts[1]
    }

    public func getSignature():String {
        return this.parts[2]
    }


    public func getType(): String {
        this.header.getType()
    }

    public func getAlgorithm(): String {
        this.header.getAlgorithm()
    }

    public func getIssuer(): String {
        return this.payload.getIssuer()
    }

    public func getSubject(): String {
        return this.payload.getSubject()
    }

    public func getAudience(): String {
        return this.payload.getAudience()
    }

    public func getExpiresAt(): Time {
        return this.payload.getExpiresAt()
    }

    public func getNotBefore(): Time {
        return this.payload.getNotBefore()
    }

    public func getIssuedAt(): Time {
        return this.payload.getIssuedAt()
    }

    public func getId(): String {
        return this.payload.getId()
    }

    public func getClaim(name: String): Claim {
        return this.payload.getClaim(name)
    }

    public func getClaims(): HashMap<String, Claim> {
        return this.payload.getClaims()
    }


    public func toString(): String {
        return this.parts[0]
    }

}