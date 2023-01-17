package jwt.exception

public open class JWTValidationException <: Exception {
    public init(message: String) {
        super(message)
    }
}
