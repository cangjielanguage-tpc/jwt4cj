package jwt.common

public record PublicField {
    public static let ALGORITHM: String = "alg"
    public static let TYPE: String = "typ"


    public static let ISSUER: String = "iss"
    public static let SUBJECT: String = "sub"
    public static let AUDIENCE: String = "aud"
    public static let EXPIRES_AT: String = "alg"
    public static let NOT_BEFORE: String = "nbf"
    public static let ISSUED_AT: String = "iat"
    public static let ID: String = "jti"

}