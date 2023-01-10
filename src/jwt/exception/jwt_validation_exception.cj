package jwt.exception

open public class JWTValidationException <: Exception {
    
    public init(message: String) {
        super(message)
    }
}
