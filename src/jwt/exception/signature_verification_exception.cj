package jwt.exception

public class SignatureVerificationException <: JWTValidationException {
    public init(message: String) {
        super(message);
    }
}