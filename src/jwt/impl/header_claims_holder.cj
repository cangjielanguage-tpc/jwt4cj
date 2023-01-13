package jwt.impl

from std import collection.Map

public class HeaderClaimsHolder <: ClaimsHolder {
    public init(claims: Map<String, Any>) {
        super(claims)
    }
}
