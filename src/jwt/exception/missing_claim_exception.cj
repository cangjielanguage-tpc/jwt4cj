package jwt.exception

public open class MissingClaimException <: InvalidClaimException {
    private var claimName: String

    public init() {
        super("The Claim is not present in the JWT.")
        this.claimName = ""
    }

    public init(claimName: String) {
        super("The Claim '${claimName}' is not present in the JWT.")
        this.claimName = claimName
    }

    public func getClaimName(): String {
        return this.claimName
    }
}
