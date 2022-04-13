package jwt.exception

public class JWTEncodeException <: RuntimeException {

    
    public init(message: String) {
        super(message);
    }
}