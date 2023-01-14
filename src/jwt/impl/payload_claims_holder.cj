package jwt.impl

public class PayloadClaimsHolder <: ClaimsHolder {
    public init(claims: Map<String, Any>) {
        super(claims)
    }
}
