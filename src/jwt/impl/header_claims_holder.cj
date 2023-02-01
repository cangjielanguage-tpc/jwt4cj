package jwt.impl

public class HeaderClaimsHolder <: ClaimsHolder {
    public init(claims: Map<String, Any>) {
        super(claims)
    }
}
