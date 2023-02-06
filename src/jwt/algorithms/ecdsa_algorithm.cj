package jwt.algorithms

from std import math.*
from cryptocj import eccj.*
from cryptocj import sha256cj.*
from cryptocj import sha384cj.*
from cryptocj import sha512cj.*

class ECDSAAlgorithm <: Algorithm {

    private let keyProvider: ECDSAKeyProvider<Array<UInt8>, Array<UInt8>>
    private let ecNumberSize: Int64
    private var filename: String

    init(filename: String, id: String, algorithm: String, ecNumberSize: Int64, keyProvider: ECDSAKeyProvider<Array<UInt8>, Array<UInt8>>) {
        super(id, algorithm)
        this.filename = filename
        this.keyProvider = keyProvider
        this.ecNumberSize = ecNumberSize
    }

    public func verify(jwt: DecodedJWT): Unit {

        try {
            var signatureBytes: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            var sinStr: SINSTR = SINSTR(signatureBytes, Int32(signatureBytes.size))
            var publicKey: Array<UInt8> = keyProvider.getPublicKey()
            var valid: Bool = verifySignatureFor(getDescription(), publicKey, jwt.getHeader(), jwt.getPayload(), sinStr)
            if (!valid) {
                throw SignatureGenerationException("SignatureGenerationException..")
            }
        } catch (e: IllegalArgumentException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    func verifySignatureFor(algorithm: String, publicKey: Array<UInt8>, header: String, payload: String, sinStr: SINSTR): Bool {
        return verifySignatureFor(algorithm, publicKey, header.toUtf8Array(), payload.toUtf8Array(), sinStr)
    }

    func verifySignatureFor(algorithm: String, publicKey: Array<UInt8>, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>, sinStr: SINSTR): Bool {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        match (algorithm) { 
            case "SHA256withECDSA" => var keyPub: EC_KEY = ecKeyNew()
                                    let pub_key = publicKey
                                    keyPub = pemReadEcPub(filename)
                                    let ret = ecdsaVerify(contentBytes, sinStr, keyPub)
                                    ecKeyFree(keyPub)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA384withECDSA" => var keyPub: EC_KEY = ecKeyNew()
                                    let pub_key = publicKey
                                    keyPub = pemReadEcPub(filename)
                                    let ret = ecdsaVerify(contentBytes, sinStr, keyPub)
                                    ecKeyFree(keyPub)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA512withECDSA" => var keyPub: EC_KEY = ecKeyNew()
                                    let pub_key = publicKey
                                    keyPub = pemReadEcPub(filename)
                                    let ret = ecdsaVerify(contentBytes, sinStr, keyPub)
                                    ecKeyFree(keyPub)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case _ => return false
        }
    }

    public func sign(headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {

        try {
            var privateKey: Array<UInt8> = keyProvider.getPrivateKey()
            var signature: Array<UInt8> = createSignatureFor(getDescription(), privateKey, headerBytes, payloadBytes)
            return signature
        } catch (e: SignatureGenerationException) {
            throw SignatureGenerationException("SignatureGenerationException..")
        }
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        try {
            var privateKey: Array<UInt8> = keyProvider.getPrivateKey()
            var signature: Array<UInt8> = createSignatureFor(getDescription(), privateKey, contentBytes)
            return signature
        } catch (e: SignatureGenerationException) {
            throw SignatureGenerationException("SignatureGenerationException..")
        }
    }

    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        var keyPri: EC_KEY = ecKeyNew()
        keyPri = pemReadEcPri(filename)
        let buf_len = ecdsaSize(keyPri)
        let sigbuf: SIN_MALLOC = SIN_MALLOC(buf_len)
        match (algorithm) { 
            case "SHA256withECDSA" => let pri_key = privateKey
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA384withECDSA" => let pri_key = privateKey
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA512withECDSA" => let pri_key = privateKey
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()
            case _ => return Array<UInt8>()
        }
    }

    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, contentBytes: Array<UInt8>): Array<UInt8> {
        var keyPri: EC_KEY = ecKeyNew()
        keyPri = pemReadEcPri(filename)
        let buf_len = ecdsaSize(keyPri)
        let sigbuf: SIN_MALLOC = SIN_MALLOC(buf_len)
        match (algorithm) { 
            case "SHA256withECDSA" => let pri_key = privateKey
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA384withECDSA" => let pri_key = privateKey
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA512withECDSA" => let pri_key = privateKey
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()
            case _ => return Array<UInt8>()
        }
    }

    static func providerForKeys(publicKey: Array<UInt8>, privateKey: Array<UInt8>): ECDSAKeyProvider<Array<UInt8>, Array<UInt8>> {
        return ECDSAFunc(publicKey,privateKey)
    }
}

class ECDSAFunc <: ECDSAKeyProvider<Array<UInt8>, Array<UInt8>> {

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
