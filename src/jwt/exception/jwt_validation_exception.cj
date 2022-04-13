package jwt.exception

public class JWTValidationException <: RuntimeException {
    public init(message: String) {
        super(message);
    }
}