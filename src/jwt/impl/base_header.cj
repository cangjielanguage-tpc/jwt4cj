package jwt.impl

import jwt.interfaces.Claim
import jwt.interfaces.Header

public class BaseHeader <: Header {
    private let algorithm: ?String
    private let typ: ?String
    private let contentType: ?String
    private let keyId: ?String
    private let tree: Map<String, Claim>

    public init(algorithm: ?String, typ: ?String, contentType: ?String, keyId: ?String, tree: Map<String, Claim>) {
        this.algorithm = algorithm
        this.typ = typ
        this.contentType = contentType
        this.keyId = keyId
        this.tree = tree
    }

    public func getAlgorithm(): Option<String> {
        algorithm
    }

    public func getType(): Option<String> {
        typ
    }

    public func getContentType(): Option<String> {
        contentType
    }

    public func getKeyId(): Option<String> {
        keyId
    }

    public func getHeaderClaim(name: String): Option<Claim> {
        tree.get(name)
    }
}
