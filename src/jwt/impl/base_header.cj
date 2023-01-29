package jwt.impl

import jwt.interfaces.Claim
import jwt.interfaces.Header
import jwt.impl.json.MISSING_CLAIM

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

    public func getAlgorithm(): String {
        algorithm.getOrThrow()
    }

    public func getType(): String {
        typ.getOrThrow()
    }

    public func getContentType(): String {
        contentType.getOrThrow()
    }

    public func getKeyId(): String {
        keyId.getOrThrow()
    }

    public func getHeaderClaim(name: String): Claim {
        tree.get(name) ?? MISSING_CLAIM
    }
}
