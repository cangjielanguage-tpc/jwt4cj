package jwt.algorithms

from std import math.*
from cryptocj import eccj.*
from cryptocj import sha256cj.*
from cryptocj import sha384cj.*
from cryptocj import sha512cj.*

class ECDSAAlgorithm <: Algorithm {
    private let keyProviderFile: ECDSAKeyProviderFileImpl
    private let ecNumberSize: Int64

    init(id: String, algorithm: String, ecNumberSize: Int64, keyProviderFile: ECDSAKeyProviderFileImpl) {
        super(id, algorithm)
        this.keyProviderFile = keyProviderFile
        this.ecNumberSize = ecNumberSize
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            let content = buildContent(jwt.getHeader(), jwt.getPayload())
            let signature = Base64Util.urlDecode2Byte(jwt.getSignature())
            let valid = verify(content, signature)
            if (!valid) {
                throw SignatureGenerationException("SignatureGenerationException..")
            }
        } catch (e: IllegalArgumentException) {
            throw SignatureVerificationException("SignatureVerificationException..")
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
        let uchash = shaFunc(content)
        var keyPub: EC_KEY = ecKeyNew()
        keyPub = pemReadEcPub(keyProviderFile.getPublicKey())
        let sinStr: SINSTR = SINSTR(signature, Int32(signature.size))
        let ret = ecdsaVerify(uchash, sinStr, keyPub)
        ecKeyFree(keyPub)
        ret == 1
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
        var keyPri: EC_KEY = ecKeyNew()
        keyPri = pemReadEcPri(keyProviderFile.getPrivateKey())
        let buf_len: Int32 = ecdsaSize(keyPri)
        let sigbuf: SIN_MALLOC = SIN_MALLOC(buf_len)
        let sin: SINSTR = ecdsaSign(uchash, sigbuf, keyPri)
        sin.getSinStr()
    }
}
