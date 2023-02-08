package jwt.algorithms

import jwt.utils.*
from cryptocj import rsacj.*
from cryptocj import sha256cj.*
from cryptocj import sha384cj.*
from cryptocj import sha512cj.*

class RSAAlgorithm <: Algorithm {

    private var keyProviderFile: RSAKeyProviderFileImpl

    init(id: String, algorithm: String, keyProviderFile: RSAKeyProviderFileImpl) {
        super(id, algorithm)
        this.keyProviderFile = keyProviderFile
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            var signatureBytes: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            var valid: Bool = verifySignatureFor(getDescription(), keyProviderFile, jwt.getHeader(), jwt.getPayload(), signatureBytes)
            if (!valid) {
                throw SignatureGenerationException("exception func in verify")
            }
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    func verifySignatureFor(algorithm: String, keyProviderFile: RSAKeyProviderFileImpl, header: String, payload: String, signatureBytes: Array<UInt8>): Bool {
        return verifySignatureFor(algorithm, keyProviderFile, header.toUtf8Array(), payload.toUtf8Array(), signatureBytes)
    }

    func verifySignatureFor(algorithm: String, keyProviderFile: RSAKeyProviderFileImpl, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>, signatureBytes: Array<UInt8>): Bool {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        match (algorithm) { 
            case "SHA256withRSA" => var uchash = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                                    let rsa: RSA = pemReadRsaPub(keyProviderFile.getPublicKey(), false, 1)
                                    sha256(contentBytes, uchash)
                                    let ret = rsaVerify(RsaTypeId.NID_sha256, uchash, UInt32(SHA256_DIGEST_LENGTH), signatureBytes, rsa)
                                    rsaFree(rsa)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA384withRSA" => var uchash = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                                    let rsa: RSA = pemReadRsaPub(keyProviderFile.getPublicKey(), false, 1)
                                    sha384(contentBytes, uchash)
                                    let ret = rsaVerify(RsaTypeId.NID_sha384, uchash, UInt32(SHA384_DIGEST_LENGTH), signatureBytes, rsa)
                                    rsaFree(rsa)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA512withRSA" => var uchash = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                                    let rsa: RSA = pemReadRsaPub(keyProviderFile.getPublicKey(), false, 1)
                                    sha512(contentBytes, uchash)
                                    let ret = rsaVerify(RsaTypeId.NID_sha512, uchash, UInt32(SHA512_DIGEST_LENGTH), signatureBytes, rsa)
                                    rsaFree(rsa)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case _ => return false
        }
    }

    public func sign(headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        try {
            let retSignate: Array<UInt8> = createSignatureFor(getDescription(), keyProviderFile, headerBytes, payloadBytes)
            return retSignate
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        try {
            let retSignate: Array<UInt8> = createSignatureFor(getDescription(), keyProviderFile, contentBytes)
            return retSignate
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }
 
    func createSignatureFor(algorithm: String, keyProviderFile: RSAKeyProviderFileImpl, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        let rsa: RSA = pemReadRsaPri(keyProviderFile.getPrivateKey(), false)
        match (algorithm) { 
            case "SHA256withRSA" => var uchash = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                                    sha256(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha256, uchash, UInt32(SHA256_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA384withRSA" => var uchash = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                                    sha384(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha384, uchash, UInt32(SHA384_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA512withRSA" => var uchash = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                                    sha512(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha512, uchash, UInt32(SHA512_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case _ => return Array<UInt8>()
        }
    }

    func createSignatureFor(algorithm: String, keyProviderFile: RSAKeyProviderFileImpl, contentBytes: Array<UInt8>): Array<UInt8> {
        let rsa: RSA = pemReadRsaPri(keyProviderFile.getPrivateKey(), false)
        match (algorithm) { 
            case "SHA256withRSA" => var uchash = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                                    sha256(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha256, uchash, UInt32(SHA256_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA384withRSA" => var uchash = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                                    sha384(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha384, uchash, UInt32(SHA384_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA512withRSA" => var uchash = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                                    sha512(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha512, uchash, UInt32(SHA512_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case _ => return Array<UInt8>()
        }
    }
}
