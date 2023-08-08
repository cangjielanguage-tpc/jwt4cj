package jwt.algorithms

from std import fs.File

public class RSAKeyProviderFileImpl <: RSAKeyProvider<RSAPublicKey, RSAPrivateKey> {
    private var rsaPublicKey: ?RSAPublicKey
    private var rsaPrivateKey: ?RSAPrivateKey

    public init(filePath: String) {
        rsaPublicKey = try {
            RSA.readPubKeyfromFile(filePath)
        } catch (_) {
            None
        }
        rsaPrivateKey = try {
            RSA.readPriKeyfromFile(filePath)
        } catch (_) {
            None
        }
    }

    public init(privateKeyFile: String, publicKeyFile: String) {
        this.rsaPublicKey = RSA.readPubKeyfromFile(publicKeyFile)
        this.rsaPrivateKey = RSA.readPriKeyfromFile(privateKeyFile)
    }

    public func getPublicKey(): RSAPublicKey {
        rsaPublicKey.getOrThrow()
    }

    public func getPrivateKey(): RSAPrivateKey {
        rsaPrivateKey.getOrThrow()
    }
}

public class RSAKeyProviderImpl <: RSAKeyProvider<RSAPublicKey, RSAPrivateKey> {
    private var rsaPublicKey: ?RSAPublicKey
    private var rsaPrivateKey: ?RSAPrivateKey

    public init(privateKey: RSAPrivateKey, publicKey: RSAPublicKey) {
        this.rsaPublicKey = publicKey
        this.rsaPrivateKey = privateKey
    }
    public init(privateKey: Array<UInt8>, publicKey: Array<UInt8>) {
        this.rsaPublicKey = RSA.setPublicKey(publicKey)
        this.rsaPrivateKey = RSA.setPrivateKey(privateKey)
    }
    public func getPublicKey(): RSAPublicKey {
        rsaPublicKey.getOrThrow()
    }
    public func getPrivateKey(): RSAPrivateKey {
        rsaPrivateKey.getOrThrow()
    }
}
