package jwt.exception

public open class JWTCreationException <: Exception {
    public init(message: String) {
        super(message)
    }
}
