package jwt.algorithms

from std import math.*
from crypto4cj import eccj.*

class ECDSAAlgorithm <: Algorithm {
    private let keyProvider: ECDSAKeyProvider<ECPublicKey, ECPrivateKey>
    private let ecNumberSize: Int64

    init(id: String, algorithm: String, ecNumberSize: Int64, keyProvider: ECDSAKeyProvider<ECPublicKey, ECPrivateKey>) {
        super(id, algorithm)
        this.keyProvider = keyProvider
        this.ecNumberSize = ecNumberSize
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            let content = buildContent(jwt.getHeader(), jwt.getPayload())
            let signature = Base64Util.urlDecode2Byte(jwt.getSignature())
            let valid = verify(content, signature)
            if (!valid) {
                throw SignatureVerificationException("SignatureVerificationException..")
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
            case "SHA256withECDSA" => verify(content, signature, sha256Func)
            case "SHA384withECDSA" => verify(content, signature, sha384Func)
            case "SHA512withECDSA" => verify(content, signature, sha512Func)
            case _ => false
        }
    }

    private func verify(
        content: Array<UInt8>,
        signature: Array<UInt8>,
        shaFunc: (Array<UInt8>) -> Array<UInt8>
    ): Bool {
        try {
            let uchash = shaFunc(content)
            EC.verify(uchash, signature, keyProvider.getPublicKey())
        } catch (_) {
            return false
        }
        return true
    }

    public func sign(content: Array<UInt8>): Array<UInt8> {
        try {
            match (getDescription()) {
                case "SHA256withECDSA" => sign(content, sha256Func)
                case "SHA384withECDSA" => sign(content, sha384Func)
                case "SHA512withECDSA" => sign(content, sha512Func)
                case _ => return Array<UInt8>()
            }
        } catch (e: SignatureGenerationException) {
            throw SignatureGenerationException("SignatureGenerationException..")
        }
    }

    private func sign(content: Array<UInt8>, shaFunc: (Array<UInt8>) -> Array<UInt8>): Array<UInt8> {
        let uchash = shaFunc(content)
        EC.sign(uchash, keyProvider.getPrivateKey())
    }
}
