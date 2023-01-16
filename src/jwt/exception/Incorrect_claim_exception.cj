package jwt.exception

import jwt.interfaces.*

public class IncorrectClaimException<T> <: InvalidClaimException {
    
    private var claimName: String
    private var claimValue: Claim<T>

    public init(message: String, claimName: String, claim: Claim<T>) {
        super(message)
        this.claimName = claimName
        this.claimValue = claim
    }
    
    public func getClaimName(): String {
        return this.claimName
    }

    public func getClaimValue(): Claim<T> {
        return this.claimValue
    }
}
