package jwt.exception

public class SignatureVerificationException <: JWTVerificationException {
    public init(algorithmName: String) {
        super("The Token's Signature resulted invalid when verified using the Algorithm: " + algorithmName);
    }
}