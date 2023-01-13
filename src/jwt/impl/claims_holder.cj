package jwt.impl

from std import collection.Map
import jwt.interfaces.NodeType

public abstract class ClaimsHolder {
    private let claims: Map<String, Any>

    protected init(claims: Map<String, Any>) {
        this.claims = claims
    }

    func getClaims(): Map<String, Any> {
        return claims
    }
}
