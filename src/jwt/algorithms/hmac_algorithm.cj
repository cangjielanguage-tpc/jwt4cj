package jwt.algorithms

import jwt.exception.*
import jwt.interfaces.*
from crypto4cj import hmaccj.*


public class HMACAlgorithm <: Algorithm {

    private var secret: Array<UInt8>

    init(id: String, algorithm: String, secretBytes: Array<UInt8>) {
        super(id, algorithm)
        secret = secretBytes
    }

    init(id: String, algorithm: String, secret: String) {
        this(id, algorithm, getSecretBytes(secret))
    }

    static func getSecretBytes(secretStr: String): Array<UInt8> {
        return secretStr.toUtf8Array()
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            var signatureBytes: Array<UInt8> = Base64Util.urlDecode2Byte(jwt.getSignature())
            var valid: Bool = verifySignatureFor(getDescription(), secret, jwt.getHeader(), jwt.getPayload(), signatureBytes)
            if (!valid) {
                throw SignatureVerificationException("HMAC exception")
            }
        } catch (e: IllegalArgumentException) {
            throw SignatureVerificationException("HMAC Algorithm exception")
        }
    }

    public func sign(headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        try {
            return createSignatureFor(getDescription(), secret, headerBytes, payloadBytes)
        } catch (e: SignatureVerificationException) {
            throw SignatureVerificationException("sign fail")
        }
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        try {
            return createSignatureFor(getDescription(), secret, contentBytes)
        } catch (e: SignatureVerificationException) {
            throw SignatureVerificationException("sign fail")
        }
    }

    func verifySignatureFor(algorithm: String, secretBytes: Array<UInt8>, header: String, payload: String, signatureBytes: Array<UInt8>): Bool {
        return verifySignatureFor(algorithm, secretBytes, header.toUtf8Array(), payload.toUtf8Array(), signatureBytes)
    }

    func verifySignatureFor(algorithm: String, secretBytes: Array<UInt8>, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>, signatureBytes: Array<UInt8>): Bool {
        return createSignatureFor(algorithm, secretBytes, headerBytes, payloadBytes) == signatureBytes
    }

    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        var hmac: HMACCJ = HMACCJ()
        var arr: Array<UInt8> = Array<UInt8>()
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        match (algorithm) {
            case "HmacSHA256" => hmac.hmacInit(privateKey, AlgorithmType.Sha256)
                                 arr = Array<UInt8>(Int64(AlgorithmType.Sha256.getBits()), item: 0)
            case "HmacSHA384" => hmac.hmacInit(privateKey, AlgorithmType.Sha384)
                                 arr = Array<UInt8>(Int64(AlgorithmType.Sha384.getBits()), item: 0)
            case "HmacSHA512" => hmac.hmacInit(privateKey, AlgorithmType.Sha512)
                                 arr = Array<UInt8>(Int64(AlgorithmType.Sha512.getBits()), item: 0)
            case _ => ()
        }
        hmac.hmacUpdate(contentBytes)
        hmac.hmacFinal(arr)
        return arr
    }

    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, contentBytes: Array<UInt8>): Array<UInt8> {
        var hmac: HMACCJ = HMACCJ()
        var arr: Array<UInt8> = Array<UInt8>()
        match (algorithm) {
            case "HmacSHA256" => hmac.hmacInit(privateKey, AlgorithmType.Sha256)               
                                 arr = Array<UInt8>(Int64(AlgorithmType.Sha256.getBits()), item: 0)
            case "HmacSHA384" => hmac.hmacInit(privateKey, AlgorithmType.Sha384)
                                 arr = Array<UInt8>(Int64(AlgorithmType.Sha384.getBits()), item: 0)
            case "HmacSHA512" => hmac.hmacInit(privateKey, AlgorithmType.Sha512)
                                 arr = Array<UInt8>(Int64(AlgorithmType.Sha512.getBits()), item: 0)
            case _ => ()
        }
        hmac.hmacUpdate(contentBytes)
        hmac.hmacFinal(arr)
        return arr
    }

}
