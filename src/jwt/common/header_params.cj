package jwt.common

/*
 * Contains constants representing the JWT header parameter names.
 */
public abstract class HeaderParams {
    /*
     * The algorithm used to sign a JWT.
     */
    public static let ALGORITHM = "alg"

    /*
     * The content type of the JWT.
     */
    public static let CONTENT_TYPE = "cty"

    /*
     * The media type of the JWT.
     */
    public static let TYPE = "typ"

    /*
     * The key ID of a JWT used to specify the key for signature validation.
     */
    public static let KEY_ID = "kid"
}
