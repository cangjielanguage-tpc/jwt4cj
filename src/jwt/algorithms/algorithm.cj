package jwt.algorithms

import jwt.impl.*

public abstract class Algorithm {
    
    private var name: String
    private var description: String

    protected init(name: String, description: String) {
        this.name = name
        this.description = description
    }

    public static func RSA256(keyProvider: RSAKeyProviderFileImpl): Algorithm {
        return RSAAlgorithm("RS256", "SHA256withRSA", keyProvider)
    }

    public static func RSA384(keyProvider: RSAKeyProviderFileImpl): Algorithm {
        return RSAAlgorithm("RS384", "SHA384withRSA", keyProvider)
    }

    public static func RSA512(keyProvider: RSAKeyProviderFileImpl): Algorithm {
        return RSAAlgorithm("RS512", "SHA512withRSA", keyProvider)
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

    public static func ECDSA256(keyProvider: ECDSAKeyProviderFileImpl): Algorithm {
        return ECDSAAlgorithm("ES256", "SHA256withECDSA", 32, keyProvider)
    }

    public static func ECDSA384(keyProvider: ECDSAKeyProviderFileImpl): Algorithm {
        return ECDSAAlgorithm("ES384", "SHA384withECDSA", 32, keyProvider)
    }

    public static func ECDSA512(keyProvider: ECDSAKeyProviderFileImpl): Algorithm {
        return ECDSAAlgorithm("ES512", "SHA512withECDSA", 32, keyProvider)
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
        
        var contentBytes: Array<UInt8> = Array<UInt8>((headerBytes.size + payloadBytes.size + 1), item: 0)
        headerBytes.copyTo(contentBytes, 0, 0, headerBytes.size)
        contentBytes[headerBytes.size] = b'.'
        payloadBytes.copyTo(contentBytes, 0, (headerBytes.size + 1), payloadBytes.size)
        return sign(contentBytes)
    }

    public func sign(contentBytes: Array<UInt8>): Array<UInt8>

}
