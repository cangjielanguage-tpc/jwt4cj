package jwt.algorithms

from encoding import base64.*
import jwt.exception.*
import jwt.interfaces.*
from cryptocj import hmaccj.*
from encoding import hex.*

public class HMACAlgorithm <: Algorithm {

    private var secret: Array<UInt8> = Array<UInt8>()
    private static let JWT_PART_SEPARATOR: Array<UInt8> = [46]

    init(id: String, algorithm: String, secretBytes: Array<UInt8>) {
        super(id, algorithm)
        // secretBytes.copyTo(secret, 0, 0, secretBytes.size)
        this.secret = secretBytes.clone()
    }

    init(id: String, algorithm: String, secret: String) {
        this(id, algorithm, getSecretBytes(secret))
    }

    static func getSecretBytes(secretStr: String): Array<UInt8> {
        return secretStr.toUtf8Array()
    }

    public func verify(jwt: DecodedJWT): Unit {
        try {
            var signatureBytes: Array<UInt8> = fromBase64String(jwt.getSignature()).getOrThrow()
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
        match (algorithm) {
            case "HmacSHA256" => hmac.hmacInit(privateKey, AlgorithmType.SHA256)
                                 arr = Array<UInt8>(Int64(AlgorithmType.SHA256.getBits()), item: 0)
            case "HmacSHA384" => hmac.hmacInit(privateKey, AlgorithmType.SHA384)
                                 arr = Array<UInt8>(Int64(AlgorithmType.SHA384.getBits()), item: 0)
            case "HmacSHA512" => hmac.hmacInit(privateKey, AlgorithmType.SHA512)
                                 arr = Array<UInt8>(Int64(AlgorithmType.SHA512.getBits()), item: 0)
            case _ => ""
        }
        hmac.hmacUpdate(headerBytes)
        hmac.hmacUpdate(payloadBytes)
        hmac.hmacUpdate(JWT_PART_SEPARATOR)
        hmac.hmacFinal(arr)
        return arr
    }

    func createSignatureFor(algorithm: String, privateKey: Array<UInt8>, contentBytes: Array<UInt8>): Array<UInt8> {
        var hmac1: HMACCJ = HMACCJ()
        var arr: Array<UInt8> = Array<UInt8>()
        match (algorithm) {
            case "HmacSHA256" => hmac1.hmacInit(privateKey, AlgorithmType.SHA256)
                                 hmac1.hmacUpdate(contentBytes)
                                 arr = Array<UInt8>(Int64(AlgorithmType.SHA256.getBits()), item: 0)
            case "HmacSHA384" => hmac1.hmacInit(privateKey, AlgorithmType.SHA384)
                                 hmac1.hmacUpdate(contentBytes)
                                 arr = Array<UInt8>(Int64(AlgorithmType.SHA384.getBits()), item: 0)
            case "HmacSHA512" => hmac1.hmacInit(privateKey, AlgorithmType.SHA512)
                                 hmac1.hmacUpdate(contentBytes)
                                 arr = Array<UInt8>(Int64(AlgorithmType.SHA512.getBits()), item: 0)
            case _ => ""
        }
        hmac1.hmacFinal(arr)
        return arr
    }

}
