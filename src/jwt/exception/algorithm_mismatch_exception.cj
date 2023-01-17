package jwt.exception

public class AlgorithmMismatchException <: JWTVerificationException {
    public init(message: String) {
        super(message)
    }
}
