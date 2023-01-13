package jwt.algorithms

class NoneAlgorithm <: Algorithm {

    init() {
        super("none", "none")
    }

    public func verify(jwt: DecodedJWT): Unit {

        try {
            var signatureBytes: Array<UInt8> = fromBase64String(jwt.getSignature()).getOrThrow()
            if (signatureBytes.size > 0) {
                throw SignatureVerificationException("noneAlgorithm exception")
            }
        } catch (e: IllegalArgumentException) {
            throw SignatureVerificationException("noneAlgorithm exception")
        }
    }

    public func sign(headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        return Array<UInt8>()
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        return Array<UInt8>()
    }
}
