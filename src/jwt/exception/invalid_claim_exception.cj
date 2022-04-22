package jwt.exception

public class InvalidClaimException  <: RuntimeException {

    public init(message: String) {
        super(message);
    }
}