package jwt.algorithms

public abstract class Algorithm {
    private var name: String
    private var description: String

    protected init(name: String, description: String) {
        this.name = name
        this.description = description
    }

    public static func HMAC256(secret: String): Algorithm {
        return HMACAlgorithm("HS256", "HmacSHA256", secret)
    }

    public static func HMAC256(secret: Array<UInt8>): Algorithm {
        return HMACAlgorithm("HS256", "HmacSHA256", secret)
    }

    public static func HMAC384(secret: String): Algorithm {
        return HMACAlgorithm("HS384", "HmacSHA384", secret)
    }

    public static func HMAC384(secret: Array<UInt8>): Algorithm {
        return HMACAlgorithm("HS384", "HmacSHA384", secret)
    }

    public static func HMAC512(secret: String): Algorithm {
        return HMACAlgorithm("HS512", "HmacSHA512", secret)
    }

    public static func HMAC512(secret: Array<UInt8>): Algorithm {
        return HMACAlgorithm("HS512", "HmacSHA512", secret)
    }

    func getDescription(): String {
        return description
    }

    public static func none(): Algorithm {
        return NoneAlgorithm()
    }

    public open func getSigningKeyId(): String {
        return ""
    }

    public func getName(): String {
        return name
    }

    public func toString(): String {
        return description
    }

    public func verify(jwt: DecodedJWT): Unit

    public open func sign(headerBytes: Array<UInt8>, payloadBytes: Array<UInt8>): Array<UInt8> {
        var contentBytes: Array<UInt8> = Array<UInt8>()
        contentBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        Char.intoUtf8Array('.', contentBytes, headerBytes.size)
        contentBytes.copyTo(contentBytes, 0, 0, payloadBytes.size)
        return sign(contentBytes)
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8>
}
