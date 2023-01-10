package jwt.interfaces

from std import time.*
from std import collection.*

public interface Payload <: ToString {
    func getIssuer(): String
    func getSubject(): String
    func getAudience(): String
    func getExpiresAt(): UInt64
    func getNotBefore(): UInt64
    func getIssuedAt(): UInt64
    func getId(): String
    func getClaim(name: String): Claim
    func getClaims(): HashMap<String, Claim>
}
