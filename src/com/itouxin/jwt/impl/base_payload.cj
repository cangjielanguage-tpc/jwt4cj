package com.itouxin.jwt.impl

from std import time.*
from std import collection.*

import com.itouxin.jwt.interfaces.*


public class BasePayload <: Payload {
    private var issuer: String = ""
    private var subject: String = ""
    private var audience: String = ""
    private var expiresAt: Time = Time.now()
    private var notBefore: Time = Time.now()
    private var issuedAt: Time = Time.now()
    private var id: String = ""
    private var claim: HashMap<String, Claim> = HashMap()

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

    public func getAudience(): String {
        return this.audience
    }

    
    public func getExpiresAt(): Time {
        return expiresAt
    }
    public func getNotBefore(): Time {
        return notBefore
    }
    public func getIssuedAt(): Time {
        return issuedAt
    }
    public func getId(): String {
        return id
    }
    public func getClaim(name:String): Claim {
        return claim[name]
    }
    public func getClaims(): HashMap<String, Claim> {
        return claim
    }

    
}