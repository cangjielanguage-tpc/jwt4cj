package jwt.algorithms

import jwt.utils.*
from cryptocj import rsacj.*
from cryptocj import sha256cj.*
from cryptocj import sha384cj.*
from cryptocj import sha512cj.*

class RSAAlgorithm <: Algorithm {
    private let keyProviderFile: RSAKeyProviderFileImpl

    init(id: String, algorithm: String, keyProviderFile: RSAKeyProviderFileImpl) {
        super(id, algorithm)
        this.keyProviderFile = keyProviderFile
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            let content = buildContent(jwt.getHeader(), jwt.getPayload())
            let signature: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            let valid: Bool = verify(content, signature)
            if (!valid) {
                throw SignatureGenerationException("exception func in verify")
            }
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    func verify(content: Array<UInt8>, signature: Array<UInt8>): Bool {
        match (getDescription()) {
            case "SHA256withRSA" =>
                verify(
                    content,
                    signature,
                    sha256Func,
                    RsaTypeId.NID_sha256
                )
            case "SHA384withRSA" =>
                verify(
                    content,
                    signature,
                    sha384Func,
                    RsaTypeId.NID_sha384
                )
            case "SHA512withRSA" =>
                verify(
                    content,
                    signature,
                    sha512Func,
                    RsaTypeId.NID_sha512
                )
            case _ => false
        }
    }

    private func verify(
        content: Array<UInt8>,
        signature: Array<UInt8>,
        shaFunc: (Array<UInt8>) -> Array<UInt8>,
        rsaTypeId: RsaTypeId
    ): Bool {
        var uchash = shaFunc(content)
        let rsa: RSA = pemReadRsaPub(keyProviderFile.getPublicKey(), false, 1)
        let ret = rsaVerify(rsaTypeId, uchash, UInt32(uchash.size), signature, rsa)
        rsaFree(rsa)
        ret == 1
    }

    public func sign(content: Array<UInt8>): Array<UInt8> {
        try {
            match (getDescription()) {
                case "SHA256withRSA" => sign(content, sha256Func, RsaTypeId.NID_sha256)
                case "SHA384withRSA" => sign(content, sha384Func, RsaTypeId.NID_sha384)
                case "SHA512withRSA" => sign(content, sha512Func, RsaTypeId.NID_sha512)
                case _ => Array<UInt8>()
            }
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    private func sign(
        content: Array<UInt8>,
        shaFunc: (Array<UInt8>) -> Array<UInt8>,
        rsaTypeId: RsaTypeId
    ): Array<UInt8> {
        let uchash = shaFunc(content)
        let rsa: RSA = pemReadRsaPri(keyProviderFile.getPrivateKey(), false)
        let (ret, signret) = rsaSign(rsaTypeId, uchash, UInt32(uchash.size), rsa)
        rsaFree(rsa)
        signret
    }
}
