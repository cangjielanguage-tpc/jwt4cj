package jwt.impl

from std import time.Time
from std import collection.ArrayList
import jwt.interfaces.Claim
import jwt.interfaces.Header

public class BasePayload <: Payload {
    private let issuer: ?String
    private let subject: ?String
    private let audience: ?ArrayList<String>
    private let expiresAt: ?Time
    private let notBefore: ?Time
    private let issuedAt: ?Time
    private let jwtId: ?String
    private let tree: Map<String, Claim>

    public init(
        issuer: ?String,
        subject: ?String,
        audience: ?ArrayList<String>,
        expiresAt: ?Time,
        notBefore: ?Time,
        issuedAt: ?Time,
        jwtId: ?String,
        tree: Map<String, Claim>
    ) {
        this.issuer = issuer
        this.subject = subject
        this.audience = audience
        this.expiresAt = expiresAt
        this.notBefore = notBefore
        this.issuedAt = issuedAt
        this.jwtId = jwtId
        this.tree = tree
    }

    public func getIssuer(): Option<String> {
        issuer
    }

    public func getSubject(): Option<String> {
        subject
    }

    public func getAudience(): Option<ArrayList<String>> {
        audience
    }

    public func getExpiresAt(): Option<Time> {
        expiresAt
    }

    public func getNotBefore(): Option<Time> {
        notBefore
    }

    public func getIssuedAt(): Option<Time> {
        issuedAt
    }

    public func getId(): Option<String> {
        jwtId
    }

    public func getClaim(name: String): Option<Claim> {
        tree.get(name)
    }

    public func getClaims(): Map<String, Claim> {
        tree
    }
}
