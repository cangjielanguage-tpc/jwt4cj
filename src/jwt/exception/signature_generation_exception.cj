package jwt.exception


public class SignatureGenerationException <: JWTCreationException {

    public init(algorithmName: String) {
        super("The Token's Signature couldn't be generated when signing using the Algorithm: " + algorithmName)
    }
}
