package jwt.exception

public class InvalidClaimException <: Exception {

    public init(message: String) {
        super(message)
    }
}
