package jwt.exception

public class JWTDecodeException <: JWTVerificationException {

    public init(message: String) {
        super(message)
    }
}
