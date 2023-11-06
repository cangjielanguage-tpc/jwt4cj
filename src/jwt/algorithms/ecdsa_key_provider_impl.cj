package jwt.algorithms

public class ECDSAKeyProviderFileImpl <: ECDSAKeyProvider<ECDSAPublicKey, ECDSAPrivateKey> {
    private var ecPublicKey: ?ECDSAPublicKey
    private var ecPrivateKey: ?ECDSAPrivateKey

    public init(filePath: String, password!: ?String = None) {
        let bytes = File.readFrom(filePath)
        let text = String.fromUtf8(bytes)
        this.ecPublicKey = try {
            ECDSAPublicKey.decodeFromPem(text)
        } catch (_) {
            None
        }
        this.ecPrivateKey = try {
            ECDSAPrivateKey.decodeFromPem(text, password: password)
        } catch (_) {
            None
        }
    }

    public init(privateKeyFile: ?String, publicKeyFile: ?String, password!: ?String = None) {
        this.ecPublicKey = try {
            let textpub = String.fromUtf8(File.readFrom(publicKeyFile.getOrThrow()))
            ECDSAPublicKey.decodeFromPem(textpub)
        } catch (_) {
            None
        }
        this.ecPrivateKey = try {
            let textpri = String.fromUtf8(File.readFrom(privateKeyFile.getOrThrow()))
            ECDSAPrivateKey.decodeFromPem(textpri, password: password)
        } catch (_) {
            None
        }
    }

    public func getPublicKey(): ECDSAPublicKey {
        return ecPublicKey.getOrThrow()
    }

    public func getPrivateKey(): ECDSAPrivateKey {
        return ecPrivateKey.getOrThrow()
    }
}

public class ECDSAKeyProviderImpl <: ECDSAKeyProvider<ECDSAPublicKey, ECDSAPrivateKey> {
    private var ecPublicKey: ?ECDSAPublicKey
    private var ecPrivateKey: ?ECDSAPrivateKey

    public init(privateKey: ?ECDSAPrivateKey, publicKey: ?ECDSAPublicKey) {
        this.ecPublicKey = publicKey
        this.ecPrivateKey = privateKey
    }
    public func getPublicKey(): ECDSAPublicKey {
        return ecPublicKey.getOrThrow()
    }
    public func getPrivateKey(): ECDSAPrivateKey {
        return ecPrivateKey.getOrThrow()
    }
}
