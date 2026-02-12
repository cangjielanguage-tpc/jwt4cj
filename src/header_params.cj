/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package cangjie_tpc::jwt4cj

/*
 * Contains constants representing the JWT header parameter names.
 */
public abstract class HeaderParams {
    /*
     * The algorithm used to sign a JWT.
     */
    public static let ALGORITHM: String = "alg"

    /*
     * The content type of the JWT.
     */
    public static let CONTENT_TYPE: String = "cty"

    /*
     * The media type of the JWT.
     */
    public static let TYPE: String = "typ"

    /*
     * The key ID of a JWT used to specify the key for signature validation.
     */
    public static let KEY_ID: String = "kid"
}
