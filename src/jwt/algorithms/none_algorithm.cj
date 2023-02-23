package jwt.algorithms

class NoneAlgorithm <: Algorithm {
    init() {
        super("none", "none")
    }

    public func verify(jwt: DecodedJWT): Unit {
        if (jwt.getSignature() != "") {
            throw SignatureVerificationException("noneAlgorithm exception!")
        }
    }

    public func sign(headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        let headerBytesArray: Array<UInt8> = headerBytes
        let payloadBytesArray: Array<UInt8> = payloadBytes
        return Array<UInt8>()
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8> {
        let contentBytesArray: Array<UInt8> = contentBytes
        return Array<UInt8>()
    }
}
