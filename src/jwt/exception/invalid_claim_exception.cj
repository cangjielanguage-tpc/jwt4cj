package jwt.exception

open public class InvalidClaimException <: JWTVerificationException {

    public init(message: String) {
        super(message)
    }
}
