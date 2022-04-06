package jwt.impl

from std import time.*
from std import collection.*
import jwt.common.*


public class BasePayload <: Payload & ToString {
    private var issuer: String = ""
    private var subject: String = ""
    private var audience: String = ""
    private var expiresAt: UInt64 = 0
    private var notBefore: UInt64 = 0
    private var issuedAt: UInt64 = 0
    private var id: String = ""

    private var claims: HashMap<String, Claim> = HashMap()

    public init() {
        
    }

    public func getIssuer(): String {
        return issuer
    }

    public func setIssuer(issuer: String) {
        this.issuer = issuer
    }

    public func getSubject(): String {
        return subject
    }

    public func setSubject(subject: String) {
        this.subject = subject
    }

    public func getAudience(): String {
        return this.audience
    }

    public func setAudience(audience: String) {
        this.audience = audience
    }
    
    public func getExpiresAt(): UInt64 {
        return expiresAt
    }

    public func setExpiresAt(expiresAt: UInt64) {
        this.expiresAt = expiresAt
    }

    public func getNotBefore(): UInt64 {
        return notBefore
    }

    public func setNotBefore(notBefore: UInt64) {
        this.notBefore = notBefore
    }

    public func getIssuedAt(): UInt64 {
        return issuedAt
    }

    public func setIssuedAt(issuedAt: UInt64) {
        this.issuedAt = issuedAt
    }

    public func getId(): String {
        return id
    }

    public func setId(id: String) {
        this.id = id
    }

    public func getClaim(name: String): Claim {
        return claims.get(name).getOrThrow()
    }

    public func setClaim(name: String, claim: Claim) {
        this.claims.put(name, claim)
    }

    public func getClaims(): HashMap<String, Claim> {
        return claims
    }

    public func setClaims(claims: HashMap<String, Claim>) {
        this.claims.putAll(claims)
    }


    public func toString(): String {
        return this.serialize().toJson().toString()
    }


    public func serialize(): DataModel {
        var struct = DataModelStruct().add(field<String>("iss", issuer)).add(field<UInt64> ("exp", expiresAt)).
            add(field<String>("sub", subject)).add(field<String>("aud", audience)).add(field<UInt64>("nbf", notBefore)).
            add(field<UInt64>("iat", issuedAt)).add(field<String>("jti", id))

        for ((key, v) in claims) {
            let jsonValue: JsonValue = v.getValue()
            let f: Field =  Field(key, DataModel.fromJson(jsonValue))
            struct.add(f)
        }
        return struct
    }
    
    public static func deserialize(dm: DataModel): Payload {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct") 
        }
        var result = BasePayload()
        let fields:  Buffer<Field> = dms.getFields()
        for (f in fields) {   
            let name: String = f.getName()
            if (name == PublicField.SUBJECT) {
                result.setSubject(String.deserialize(dms.get("sub")))
                continue
            }  
            if(name.equals("iss")) {
                result.setIssuer(String.deserialize(dms.get("iss")))
                continue
            }  
             if (name == "exp") {
                result.setExpiresAt(UInt64.deserialize(dms.get("exp")))
                continue
            } 
             if (name.equals("aud")) {
                result.setAudience(String.deserialize(dms.get("aud")))
                continue
            } 
             if (name.equals("nbf")) {
                result.setNotBefore(UInt64.deserialize(dms.get("nbf")))
                continue
            } 
             if (name.equals("iat")) {
                result.setIssuedAt(UInt64.deserialize(dms.get("iat")))
                continue
            } 
             if (name.equals("jti")) {
                result.setId(String.deserialize(dms.get("jti")))
                continue
            } 
            let a: JsonValue = f.getData().toJson()
            let claim : Claim = BaseClaim(a)
            result.setClaim(name, claim)
        }
        
        return result
    }


    
}