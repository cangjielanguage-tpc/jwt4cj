package jwt.algorithms

public abstract class Algorithm {
    
    private var name: String
    private var description: String

    protected init(name: String, description: String) {
        this.name = name
        this.description = description
    }

    public static func RSA256(filename: String, keyProvider: RSAKeyProvider<Array<UInt8>, Array<UInt8>>): Algorithm {
        return RSAAlgorithm(filename, "RS256", "SHA256withRSA", keyProvider)
    }

    public static func RSA256(filename: String, publicKey: Array<UInt8>, privateKey: Array<UInt8>): Algorithm {
        return RSA256(filename, RSAAlgorithm.providerForKeys(publicKey, privateKey))
    }

    public static func RSA256(filename: String, key: Array<UInt8>): Algorithm {
        var publicKey: Array<UInt8> = key
        var privateKey: Array<UInt8> = key
        return RSA256(filename, publicKey, privateKey)
    }

    public static func RSA256(filename: String): Algorithm {
        var publicKey: Array<UInt8> = []
        var privateKey: Array<UInt8> = []
        return RSA256(filename, publicKey, privateKey)
    }

    public static func RSA384(filename: String, keyProvider: RSAKeyProvider<Array<UInt8>, Array<UInt8>>): Algorithm {
        return RSAAlgorithm(filename, "RS384", "SHA384withRSA", keyProvider)
    }

    public static func RSA384(filename: String, publicKey: Array<UInt8>, privateKey: Array<UInt8>): Algorithm {
        return RSA384(filename, RSAAlgorithm.providerForKeys(publicKey, privateKey))
    }

    public static func RSA384(filename: String, key: Array<UInt8>): Algorithm {
        var publicKey: Array<UInt8> = key
        var privateKey: Array<UInt8> = key
        return RSA384(filename, publicKey, privateKey)
    }

    public static func RSA384(filename: String): Algorithm {
        var publicKey: Array<UInt8> = []
        var privateKey: Array<UInt8> = []
        return RSA384(filename, publicKey, privateKey)
    }

    public static func RSA512(filename: String, keyProvider: RSAKeyProvider<Array<UInt8>, Array<UInt8>>): Algorithm {
        return RSAAlgorithm(filename, "RS512", "SHA512withRSA", keyProvider)
    }

    public static func RSA512(filename: String, publicKey: Array<UInt8>, privateKey: Array<UInt8>): Algorithm {
        return RSA512(filename, RSAAlgorithm.providerForKeys(publicKey, privateKey))
    }

    public static func RSA512(filename: String, key: Array<UInt8>): Algorithm {
        var publicKey: Array<UInt8> = key
        var privateKey: Array<UInt8> = key
        return RSA512(filename, publicKey, privateKey)
    }

    public static func RSA512(filename: String): Algorithm {
        var publicKey: Array<UInt8> = []
        var privateKey: Array<UInt8> = []
        return RSA512(filename, publicKey, privateKey)
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

    public static func ECDSA256(filename: String, keyProvider: ECDSAKeyProvider<Array<UInt8>, Array<UInt8>>): Algorithm {
        return ECDSAAlgorithm(filename, "ES256", "SHA256withECDSA", 32, keyProvider)
    }

    public static func ECDSA256(filename: String, publicKey: Array<UInt8>, privateKey: Array<UInt8>): Algorithm {
        return ECDSA256(filename, ECDSAAlgorithm.providerForKeys(publicKey, privateKey))
    }

    public static func ECDSA256(filename: String, key: Array<UInt8>): Algorithm {
        var publicKey: Array<UInt8> = key
        var privateKey: Array<UInt8> = key
        return ECDSA256(filename, publicKey, privateKey)
    }

    public static func ECDSA256(filename: String): Algorithm {
        var publicKey: Array<UInt8> = []
        var privateKey: Array<UInt8> = []
        return ECDSA256(filename, publicKey, privateKey)
    }

    public static func ECDSA384(filename: String, keyProvider: ECDSAKeyProvider<Array<UInt8>, Array<UInt8>>): Algorithm {
        return ECDSAAlgorithm(filename, "ES384", "SHA384withECDSA", 48, keyProvider)
    }

    public static func ECDSA384(filename: String, publicKey: Array<UInt8>, privateKey: Array<UInt8>): Algorithm {
        return ECDSA384(filename, ECDSAAlgorithm.providerForKeys(publicKey, privateKey))
    }

    public static func ECDSA384(filename: String, key: Array<UInt8>): Algorithm {
        var publicKey: Array<UInt8> = key
        var privateKey: Array<UInt8> = key
        return ECDSA384(filename, publicKey, privateKey)
    }

    public static func ECDSA384(filename: String): Algorithm {
        var publicKey: Array<UInt8> = []
        var privateKey: Array<UInt8> = []
        return ECDSA384(filename, publicKey, privateKey)
    }

    public static func ECDSA512(filename: String, keyProvider: ECDSAKeyProvider<Array<UInt8>, Array<UInt8>>): Algorithm {
        return ECDSAAlgorithm(filename, "ES512", "SHA512withECDSA", 66, keyProvider)
    }

    public static func ECDSA512(filename: String, publicKey: Array<UInt8>, privateKey: Array<UInt8>): Algorithm {
        return ECDSA512(filename, ECDSAAlgorithm.providerForKeys(publicKey, privateKey))
    }

    public static func ECDSA512(filename: String, key: Array<UInt8>): Algorithm {
        var publicKey: Array<UInt8> = key
        var privateKey: Array<UInt8> = key
        return ECDSA512(filename, publicKey, privateKey)
    }

    public static func ECDSA512(filename: String): Algorithm {
        var publicKey: Array<UInt8> = []
        var privateKey: Array<UInt8> = []
        return ECDSA512(filename, publicKey, privateKey)
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
