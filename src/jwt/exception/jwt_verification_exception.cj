package jwt.exception

/**
 * Parent to all the exception thrown while verifying a JWT.
 */
public open class JWTVerificationException <: Exception {
    public init(message: String) {
        super(message)
    }
}
