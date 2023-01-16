package jwt.interfaces

/**
 * Used to verify the JWT for its signature and claims.
 * Implementations must be thread-safe.
 * Instances are created using Verification.
 */
public interface JWTVerifier<T> {
    /**
     * Performs the verification against the given Token.
     *
     * @param token to verify.
     * @return a verified and decoded JWT.
     * @throws JWTVerificationException if any of the verification steps fail
     */
    func verify(token: String): DecodedJWT<T>

    /**
     * Performs the verification against the given DecodedJWT.
     *
     * @param jwt to verify.
     * @return a verified and decoded JWT.
     * @throws JWTVerificationException if any of the verification steps fail
     */
    func verify(jwt: DecodedJWT<T>): DecodedJWT<T>
}
