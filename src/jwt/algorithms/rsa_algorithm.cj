package jwt.algorithms

import jwt.utils.*
from crypto4cj import rsacj.*

class RSAAlgorithm <: Algorithm {
    private let keyProvider: RSAKeyProvider<RSAPublicKey, RSAPrivateKey>

    init(id: String, algorithm: String, keyProvider: RSAKeyProvider<RSAPublicKey, RSAPrivateKey>) {
        super(id, algorithm)
        this.keyProvider = keyProvider
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            let content = buildContent(jwt.getHeader(), jwt.getPayload())
            let signature: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            let valid: Bool = verify(content, signature)
            if (!valid) {
                throw SignatureVerificationException("exception func in verify")
            }
        } catch (e: Exception) {
            throw match (e) {
                case v: SignatureVerificationException => v
                case _ => SignatureVerificationException("SignatureVerificationException..")
            }
        }
    }

    func verify(content: Array<UInt8>, signature: Array<UInt8>): Bool {
        match (getDescription()) {
            case "SHA256withRSA" =>
                verify(
                    content,
                    signature,
                    DigestType.sha256
                )
            case "SHA384withRSA" =>
                verify(
                    content,
                    signature,
                    DigestType.sha384
                )
            case "SHA512withRSA" =>
                verify(
                    content,
                    signature,
                    DigestType.sha512
                )
            case _ => false
        }
    }

    private func verify(
        content: Array<UInt8>,
        signature: Array<UInt8>,
        digestType: DigestType
    ): Bool {
        try {
            let uchash = Digest.digest(digestType, content)
            RSA.verify(digestType, uchash, signature, keyProvider.getPublicKey())
        } catch (_) {
            return false
        }
        return true
    }

    public func sign(content: Array<UInt8>): Array<UInt8> {
        try {
            match (getDescription()) {
                case "SHA256withRSA" => sign(content, DigestType.sha256)
                case "SHA384withRSA" => sign(content, DigestType.sha384)
                case "SHA512withRSA" => sign(content, DigestType.sha512)
                case _ => Array<UInt8>()
            }
        } catch (_) {
            throw SignatureGenerationException("SignatureGenerationException..")
        }
    }

    private func sign(content: Array<UInt8>, digestType: DigestType): Array<UInt8> {
        let uchash = Digest.digest(digestType, content)
        RSA.sign(digestType, uchash, keyProvider.getPrivateKey())
    }
}
