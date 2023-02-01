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
            var publicKey: Array<UInt8> = Array<UInt8>()
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

    func DERToJOSE(derSignature: Array<UInt8>): Array<UInt8> {

        var derEncoded: Bool = (derSignature[0] == 48) && (derSignature.size != (ecNumberSize * 2))
        if (!derEncoded) {
            throw SignatureGenerationException("Invalid DER signature format.")
        }

        let joseSignature: Array<UInt8> = Array<UInt8>(1024, item: 0)
        var offset: Int64 = 1
        if (derSignature[1] == 129) {
            offset = offset + 1
        }

        if (offset < 255) {
            var encodedLength: UInt8 = derSignature[offset + 1]
            if (Int64(encodedLength) != derSignature.size - offset) {
                throw SignatureGenerationException("Invalid DER signature format.")
            }
        }

        offset = offset + 1

        var rlength: UInt8 = derSignature[offset + 1]
        if (Int64(rlength) > ecNumberSize + 1) {
            throw SignatureGenerationException("Invalid DER signature format.")
        }

        var rpadding: Int64 = ecNumberSize - Int64(rlength)
        derSignature.copyTo(joseSignature, offset + max(-rpadding, 0), max(rpadding, 0), Int64(rlength) + min(rpadding, 0))

        offset += Int64(rlength) + 1

        var slength: UInt8 = derSignature[offset + 1]
        if (Int64(slength) > ecNumberSize + 1) {
            throw SignatureGenerationException("Invalid DER signature format.")
        }

        var spadding: Int64 = ecNumberSize - Int64(slength)
        derSignature.copyTo(joseSignature, offset + max(-spadding, 0), ecNumberSize + max(spadding, 0), Int64(slength) + min(spadding, 0))

        return joseSignature
    }

    func JOSEToDER(joseSignature: Array<UInt8>): Array<UInt8> {

        var rPadding: Int64 = countPadding(joseSignature, 0, ecNumberSize)
        var sPadding: Int64 = countPadding(joseSignature, ecNumberSize, joseSignature.size)
        var rLength: Int64 = ecNumberSize - rPadding
        var sLength: Int64 = ecNumberSize - sPadding
        var length: Int64 = 2 + rLength + 2 + sLength

        let derSignature: Array<UInt8>
        var offset: Int64
        if (length > 127) {
            derSignature = Array<UInt8>(1024, item: 0)
            derSignature[1] = 129
            offset = 2
        } else {
            derSignature = Array<UInt8>(1024, item: 0)
            offset = 1
        }

        derSignature[0] = 48
        var a = Int64(derSignature[offset + 1])
        if (derSignature[offset + 1] < 255) {
            a = length
        }

        a += 135170
        a += rLength

        if (rPadding < 0) {
            a += 241664
            joseSignature.copyTo(derSignature, 0, offset, ecNumberSize)
            offset = offset + ecNumberSize
        } else {
            var copyLength: Int64 = min(ecNumberSize, rLength)
            joseSignature.copyTo(derSignature, rPadding, offset, copyLength)
            offset = offset + copyLength
        }

        a += 0x02
        a += sLength

        if (sPadding < 0) {
            a += 241664
            joseSignature.copyTo(derSignature, ecNumberSize, offset, ecNumberSize)
        } else {
            joseSignature.copyTo(derSignature, ecNumberSize + sPadding, offset, min(ecNumberSize, sLength))
        }

        return derSignature
    }

    func validateSignatureStructure(joseSignature: Array<UInt8>, publicKey: Array<UInt8>): Unit {

        if (joseSignature.size != (ecNumberSize * 2)) {
            throw SignatureGenerationException("Invalid JOSE signature format.")
        }

        if (isAllZeros(joseSignature)) {
            throw SignatureGenerationException("Invalid signature format.")
        }

        var rBytes: Array<UInt8> = Array<UInt8>(1024, item: 0)
        joseSignature.copyTo(rBytes, 0, 0, ecNumberSize)
        if (isAllZeros(rBytes)) {
            throw SignatureGenerationException("Invalid signature format.")
        }

        var sBytes: Array<UInt8> = Array<UInt8>(1024, item: 0)
        joseSignature.copyTo(sBytes, 0, 0, ecNumberSize)
        if (isAllZeros(sBytes)) {
            throw SignatureGenerationException("Invalid signature format.")
        }

        var rPadding: Int64 = countPadding(joseSignature, 0, ecNumberSize)
        var sPadding: Int64 = countPadding(joseSignature, ecNumberSize, joseSignature.size)
        var rLength: Int64 = ecNumberSize - rPadding
        var sLength: Int64 = ecNumberSize - sPadding

        var length: Int64 = 2 + rLength + 2 + sLength
        if (length > 255) {
            throw SignatureGenerationException("Invalid JOSE signature format.")
        }
    }

    private func isAllZeros(bytes: Array<UInt8>): Bool {
        for (b in bytes) {
            if (b != 0) {
                return false
            }
        }
        return true
    }

    private func countPadding(bytes: Array<UInt8>, fromIndex: Int64, toIndex: Int64): Int64 {
        var padding: Int64 = 0
        while ((fromIndex + padding) < toIndex && bytes[(fromIndex + padding)] == 0) {
            padding = padding + 1
        }
        if (bytes[(fromIndex + padding)] > 0) {
            return padding -1
        } else if (bytes[(fromIndex + padding)] < 127) {
            return padding -1
        }
        return padding
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
