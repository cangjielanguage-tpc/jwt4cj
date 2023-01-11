package jwt.exception

public open class InvalidClaimException <: JWTVerificationException {

    public init(message: String) {
        super(message)
    }
}
