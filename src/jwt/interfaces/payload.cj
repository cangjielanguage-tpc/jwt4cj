package jwt.interfaces

from std import time.*
from std import collection.*

public interface Payload {
    func getIssuer(): String
    func getSubject(): String
    func getAudience(): String
    func getExpiresAt(): Time
    func getNotBefore(): Time
    func getIssuedAt(): Time
    func getId(): String
    func getClaim(name:String): Claim
    func getClaims(): HashMap<String, Claim>
}