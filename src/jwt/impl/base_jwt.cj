package jwt.impl

import jwt.interfaces.*
import jwt.exception.*

public class BaseJWT <: DecodeJWT & Header & Payload & Serializable<DecodeJWT> {

    private var parts: Array<String>
    private var header: Header
    private var payload: Payload

    init(parts: Array<String>) {
        this.parts = parts
        try {
            this.header = JWTParser.parseHeader(parts[0])
            this.payload = JWTParser.parsePayload(parts[1])
        } catch (e: Exception) {
            e.printStackTrace()
            throw e
        }
    }

    public static func fromString(jwt: String): BaseJWT {
        
        let parts: Array<String> = jwt.split('.')
        if (parts.size() < 2) {
            throw JWTDecodeException("The token was expected to have more then 2 parts, but got ${parts.size()}.")
        }
        return BaseJWT(parts)
    }

    
    public func getEncodedHeader(): String {
        return this.parts[0]
    }


    public func getHeader(): Header {
        return this.header
    }

    public func getEncodedPayload(): String {
        return this.parts[1]
    }


    public func getPayload(): Payload {
        return this.payload
    }

    public func getSignature():String {
        return this.parts[2]
    }


    public func getToken(): String {
        return "${parts[0]}.${parts[1]}.${parts[2]}"
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

    public func getContentType(): String {
        return this.header.getContentType()
    }

    public func getSubject(): String {
        return this.payload.getSubject()
    }

    public func getAudience(): String {
        return this.payload.getAudience()
    }

    public func getExpiresAt(): UInt64 {
        return this.payload.getExpiresAt()
    }

    public func getNotBefore(): UInt64 {
        return this.payload.getNotBefore()
    }

    public func getIssuedAt(): UInt64 {
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


    public func serialize(): DataModel {
        return DataModelStruct().add(field<String>("parts", ""))
    }
    
    public static func deserialize(dm: DataModel): BaseJWT {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct") 
        }
    
        return BaseJWT.fromString(String.deserialize(dms.get("parts")))
    }


}