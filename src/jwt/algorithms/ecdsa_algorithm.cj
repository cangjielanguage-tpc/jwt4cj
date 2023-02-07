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
            var signatureBytes: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            var sinStr: SINSTR = SINSTR(signatureBytes, Int32(signatureBytes.size))
            var valid: Bool = verifySignatureFor(getDescription(), keyProviderFile, jwt.getHeader(), jwt.getPayload(), sinStr)
            if (!valid) {
                throw SignatureGenerationException("SignatureGenerationException..")
            }
        } catch (e: IllegalArgumentException) {
            throw SignatureVerificationException("SignatureVerificationException..")
        }
    }

    func verifySignatureFor(algorithm: String, keyProviderFile: ECDSAKeyProviderFileImpl, header: String, payload: String, sinStr: SINSTR): Bool {
        return verifySignatureFor(algorithm, keyProviderFile, header.toUtf8Array(), payload.toUtf8Array(), sinStr)
    }

    func verifySignatureFor(algorithm: String, keyProviderFile: ECDSAKeyProviderFileImpl, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>, sinStr: SINSTR): Bool {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        match (algorithm) { 
            case "SHA256withECDSA" => var keyPub: EC_KEY = ecKeyNew()
                                    keyPub = pemReadEcPub(keyProviderFile.getPublicKey())
                                    let ret = ecdsaVerify(contentBytes, sinStr, keyPub)
                                    ecKeyFree(keyPub)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA384withECDSA" => var keyPub: EC_KEY = ecKeyNew()
                                    keyPub = pemReadEcPub(keyProviderFile.getPublicKey())
                                    let ret = ecdsaVerify(contentBytes, sinStr, keyPub)
                                    ecKeyFree(keyPub)
                                    if (ret != 1) {
                                        return false
                                    }
                                    return true

            case "SHA512withECDSA" => var keyPub: EC_KEY = ecKeyNew()
                                    keyPub = pemReadEcPub(keyProviderFile.getPublicKey())
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
            var signature: Array<UInt8> = createSignatureFor(getDescription(), keyProviderFile, headerBytes, payloadBytes)
            return signature
        } catch (e: SignatureGenerationException) {
            throw SignatureGenerationException("SignatureGenerationException..")
        }
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        try {
            var signature: Array<UInt8> = createSignatureFor(getDescription(), keyProviderFile, contentBytes)
            return signature
        } catch (e: SignatureGenerationException) {
            throw SignatureGenerationException("SignatureGenerationException..")
        }
    }

    func createSignatureFor(algorithm: String, keyProviderFile: ECDSAKeyProviderFileImpl, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        var keyPri: EC_KEY = ecKeyNew()
        keyPri = pemReadEcPri(keyProviderFile.getPrivateKey())
        let buf_len: Int32 = ecdsaSize(keyPri)
        let sigbuf: SIN_MALLOC = SIN_MALLOC(buf_len)
        match (algorithm) { 
            case "SHA256withECDSA" => 
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA384withECDSA" => 
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA512withECDSA" => 
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()
            case _ => return Array<UInt8>()
        }
    }

    func createSignatureFor(algorithm: String, keyProviderFile: ECDSAKeyProviderFileImpl, contentBytes: Array<UInt8>): Array<UInt8> {
        var keyPri: EC_KEY = ecKeyNew()
        keyPri = pemReadEcPri(keyProviderFile.getPrivateKey())
        let buf_len: Int32 = ecdsaSize(keyPri)
        let sigbuf: SIN_MALLOC = SIN_MALLOC(buf_len)
        match (algorithm) { 
            case "SHA256withECDSA" => 
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA384withECDSA" => 
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()

            case "SHA512withECDSA" => 
                                      let sin: SINSTR = ecdsaSign(contentBytes, sigbuf, keyPri)
                                      return sin.getSinStr()
            case _ => return Array<UInt8>()
        }
    }

}
