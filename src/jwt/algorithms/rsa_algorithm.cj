package jwt.algorithms

import jwt.utils.*
from cryptocj import rsacj.*
from cryptocj import sha256cj.*
from cryptocj import sha384cj.*
from cryptocj import sha512cj.*

class RSAAlgorithm <: Algorithm {

    private let keyProvider: RSAKeyProvider<Array<UInt8>, Array<UInt8>>
    private var filename: String

    init(filename: String, id: String, algorithm: String, keyProvider: RSAKeyProvider<Array<UInt8>, Array<UInt8>>) {
        super(id, algorithm)
        this.filename = filename
        this.keyProvider = keyProvider
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            var signatureBytes: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            var publicKey: Array<UInt8> = keyProvider.getPublicKey()
            var valid: Bool = verifySignatureFor(getDescription(), publicKey, jwt.getHeader(), jwt.getPayload(), signatureBytes)
            if (!valid) {
                throw SignatureGenerationException("exception func in verify")
            }
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    func verifySignatureFor(algorithm: String, publicKey: Array<UInt8>, header: String, payload: String, signatureBytes: Array<UInt8>): Bool {
        return verifySignatureFor(algorithm, publicKey, header.toUtf8Array(), payload.toUtf8Array(), signatureBytes)
    }

    func verifySignatureFor(algorithm: String, publicKey: Array<UInt8>, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>, signatureBytes: Array<UInt8>): Bool {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        match (algorithm) { 
            case "SHA256withRSA" => var uchash = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                                    let pub_key = publicKey
                                    let rsa: RSA = pemReadRsaPub(filename, false, 1)
                                    sha256(contentBytes, uchash)
                                    let ret = rsaVerify(RsaTypeId.NID_sha256, uchash, UInt32(SHA256_DIGEST_LENGTH), signatureBytes, rsa)
                                    rsaFree(rsa)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA384withRSA" => var uchash = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                                    let pub_key = publicKey
                                    let rsa: RSA = pemReadRsaPub(filename, false, 1)
                                    sha384(contentBytes, uchash)
                                    let ret = rsaVerify(RsaTypeId.NID_sha384, uchash, UInt32(SHA384_DIGEST_LENGTH), signatureBytes, rsa)
                                    rsaFree(rsa)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA512withRSA" => var uchash = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                                    let pub_key = publicKey
                                    let rsa: RSA = pemReadRsaPub(filename, false, 1)
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
            let privateKey: Array<UInt8> = keyProvider.getPrivateKey()
            let retSignate: Array<UInt8> = createSignatureFor(getDescription(), privateKey, headerBytes, payloadBytes)
            return retSignate
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        try {
            var privateKey: Array<UInt8> = keyProvider.getPrivateKey()
            let retSignate: Array<UInt8> = createSignatureFor(getDescription(), privateKey, contentBytes)
            return retSignate
        } catch (e: SignatureGenerationException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }
 
    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        match (algorithm) { 
            case "SHA256withRSA" => var uchash = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                                    let pri_key = privateKey
                                    let rsa: RSA = pemReadRsaPri(filename, false)
                                    sha256(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha256, uchash, UInt32(SHA256_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA384withRSA" => var uchash = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                                    let pri_key = privateKey
                                    let rsa: RSA = pemReadRsaPri(filename, false)
                                    sha384(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha384, uchash, UInt32(SHA384_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA512withRSA" => var uchash = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                                    let pri_key = privateKey
                                    let rsa: RSA = pemReadRsaPri(filename, false)
                                    sha512(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha512, uchash, UInt32(SHA512_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case _ => return Array<UInt8>()
        }
    }

    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, contentBytes: Array<UInt8>): Array<UInt8> {
        match (algorithm) { 
            case "SHA256withRSA" => var uchash = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
                                    let pri_key = privateKey
                                    let rsa: RSA = pemReadRsaPri(filename, false)
                                    sha256(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha256, uchash, UInt32(SHA256_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA384withRSA" => var uchash = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
                                    let pri_key = privateKey
                                    let rsa: RSA = pemReadRsaPri(filename, false)
                                    sha384(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha384, uchash, UInt32(SHA384_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case "SHA512withRSA" => var uchash = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
                                    let pri_key = privateKey
                                    let rsa: RSA = pemReadRsaPri(filename, false)
                                    sha512(contentBytes, uchash)
                                    let (ret, signret) = rsaSign(RsaTypeId.NID_sha512, uchash, UInt32(SHA512_DIGEST_LENGTH), rsa)
                                    rsaFree(rsa)
                                    return signret

            case _ => return Array<UInt8>()
        }
    }

    static func providerForKeys(publicKey: Array<UInt8>, privateKey: Array<UInt8>): RSAKeyProvider<Array<UInt8>, Array<UInt8>> {
        return RsaFunc(publicKey,privateKey)
    }

}

class RsaFunc <: RSAKeyProvider<Array<UInt8>, Array<UInt8>> {

    private let publicKey: Array<UInt8>
    private let privateKey: Array<UInt8>

    init(publicKey: Array<UInt8>, privateKey: Array<UInt8>) {
        this.publicKey = publicKey
        this.privateKey = privateKey
    }
    
    public func getPublicKey(): Array<UInt8> {
        return publicKey
    }

    public func getPrivateKey(): Array<UInt8> {
        return privateKey
    }

}
