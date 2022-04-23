package jwt

import jwt.algorithm.*
import jwt.exception.AlgorithmMismatchException

class JWTValidator {
    private var jwt: DecodeJWT

    init(jwt: DecodeJWT) {
        this.jwt = jwt
    }

    public func verify(algorithm: Algorithm): Unit {
        verifyAlgorithm(algorithm);
        algorithm.verify((this.jwt.getEncodedHeader() + "." + this.jwt.getEncodedPayload()).toUtf8Array(), jwt.getSignature().toUtf8Array())
    }

    public func verify(jwt: DecodeJWT, algorithm: Algorithm): Unit {
        verify(algorithm)
        verifyPayload(jwt);
    }

    func verifyAlgorithm(algorithm: Algorithm): Unit {
        if (!algorithm.getName().equals(jwt.getAlgorithm())) {
            throw AlgorithmMismatchException("The provided Algorithm doesn't match the one defined in the JWT's Header.");
        }
    }

    func verifyPayload(jwt: DecodeJWT): Unit {
        if (!this.jwt.getAudience().equals(jwt.getAudience())) {
            throw InvalidClaimException("The Claim 'aud' value doesn't contain the required audience.");
        }
    }

    func assertIssuer(issuer: String): Unit {
        this.jwt.getIssuer()
    }
}