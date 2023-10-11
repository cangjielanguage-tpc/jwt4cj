package jwt.algorithms

public class ECDSAKeyProviderFileImpl <: ECDSAKeyProvider<ECPublicKey, ECPrivateKey> {
    private var ecPublicKey: ?ECPublicKey
    private var ecPrivateKey: ?ECPrivateKey

    public init(filePath: String) {
        ecPublicKey = try {
            EC.readPubKeyfromFile(filePath)
        } catch (_) {
            None
        }
        ecPrivateKey = try {
            EC.readPriKeyfromFile(filePath)
        } catch (_) {
            None
        }
    }

    public init(privateKeyFile: String, publicKeyFile: String) {
        this.ecPrivateKey = EC.readPriKeyfromFile(privateKeyFile)
        this.ecPublicKey = EC.readPubKeyfromFile(publicKeyFile)
    }

    public func getPublicKey(): ECPublicKey {
        return ecPublicKey.getOrThrow()
    }

    public func getPrivateKey(): ECPrivateKey {
        return ecPrivateKey.getOrThrow()
    }
}

public class ECDSAKeyProviderImpl <: ECDSAKeyProvider<ECPublicKey, ECPrivateKey> {
    private var ecPublicKey: ?ECPublicKey
    private var ecPrivateKey: ?ECPrivateKey

    public init(privateKey: ECPrivateKey, publicKey: ECPublicKey) {
        this.ecPublicKey = publicKey
        this.ecPrivateKey = privateKey
    }
    public func getPublicKey(): ECPublicKey {
        return ecPublicKey.getOrThrow()
    }
    public func getPrivateKey(): ECPrivateKey {
        return ecPrivateKey.getOrThrow()
    }
}
