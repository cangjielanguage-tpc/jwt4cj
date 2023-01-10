package jwt.interfaces

from std import time.*
from std import collection.*

/**
 * The Payload class represents the 2nd part of the JWT, where the Payload value is held.
 */
public interface Payload <: ToString {
    /**
     * Get the value of the "iss" claim, or None if it's not available.
     *
     * @return the Issuer value or None.
     */
    func getIssuer(): Option<String>

    /**
     * Get the value of the "sub" claim, or None if it's not available.
     *
     * @return the Subject value or None.
     */
    func getSubject(): Option<String>

    /**
     * Get the value of the "aud" claim, or None if it's not available.
     *
     * @return the Audience value or None.
     */
    func getAudience(): Option<ArrayList<String>>

    /**
     * Get the value of the "exp" claim, or None if it's not available.
     *
     * @return the Expiration Time value or None.
     */
    func getExpiresAt(): Option<Time>

    /**
     * Get the value of the "nbf" claim, or None if it's not available.
     *
     * @return the Not Before value or None.
     */
    func getNotBefore(): Option<Time>

    /**
     * Get the value of the "iat" claim, or None if it's not available.
     *
     * @return the Issued At value or None.
     */
    func getIssuedAt(): Option<Time>

    /**
     * Get the value of the "jti" claim, or None if it's not available.
     *
     * @return the JWT ID value or None.
     */
    func getId(): Option<String>

    /**
     * Get a Claim given its name. If the Claim wasn't specified in the Payload, a 'null claim'
     * will be returned. All the methods of that claim will return None.
     *
     * @param name the name of the Claim to retrieve.
     * @return a non-null Claim.
     */
    func getClaim(name: String): Claim

    /**
     * Get the Claims defined in the Token.
     *
     * @return a non-null Map containing the Claims defined in the Token.
     */
    func getClaims(): Map<String, Claim>
}
