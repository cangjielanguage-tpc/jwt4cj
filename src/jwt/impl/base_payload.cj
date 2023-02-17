package jwt.impl

from std import time.Time
from std import collection.ArrayList
import jwt.interfaces.Claim
import jwt.interfaces.Header
import jwt.impl.json.MISSING_CLAIM

class BasePayload <: Payload {
    private let issuer: ?String
    private let subject: ?String
    private let audience: ?ArrayList<String>
    private let expiresAt: ?Time
    private let notBefore: ?Time
    private let issuedAt: ?Time
    private let jwtId: ?String
    private let tree: Map<String, Claim>

    init(
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

    public func getIssuer(): String {
        issuer.getOrThrow()
    }

    public func getSubject(): String {
        subject.getOrThrow()
    }

    public func getAudience(): ArrayList<String> {
        audience.getOrThrow()
    }

    public func getExpiresAt(): Time {
        expiresAt.getOrThrow()
    }

    public func getNotBefore(): Time {
        notBefore.getOrThrow()
    }

    public func getIssuedAt(): Time {
        issuedAt.getOrThrow()
    }

    public func getId(): String {
        jwtId.getOrThrow()
    }

    public func getClaim(name: String): Claim {
        tree.get(name) ?? MISSING_CLAIM
    }

    public func getClaims(): Map<String, Claim> {
        tree
    }
}
