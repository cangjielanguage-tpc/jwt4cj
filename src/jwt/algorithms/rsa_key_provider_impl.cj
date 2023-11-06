package jwt.algorithms

public class RSAKeyProviderFileImpl <: RSAKeyProvider<RSAPublicKey, RSAPrivateKey> {
    private var rsaPublicKey: ?RSAPublicKey
    private var rsaPrivateKey: ?RSAPrivateKey
    private var padding: PadOption = PKCS1
    public mut prop padType: PadOption {
        get() {
            this.padding
        }
        set(value) {
            this.padding = value
        }
    }

    public init(filePath: String, password!: ?String = None) {
        let bytes = File.readFrom(filePath)
        let text = String.fromUtf8(bytes)
        this.rsaPublicKey = try {
            RSAPublicKey.decodeFromPem(text)
        } catch (_) {
            None
        }
        this.rsaPrivateKey = try {
            RSAPrivateKey.decodeFromPem(text, password: password)
        } catch (_) {
            None
        }
    }

    public init(privateKeyFile: ?String, publicKeyFile: ?String, password!: ?String = None) {
        this.rsaPublicKey = try {
            let textpub = String.fromUtf8(File.readFrom(publicKeyFile.getOrThrow()))
            RSAPublicKey.decodeFromPem(textpub)
        } catch (_) {
            None
        }
        this.rsaPrivateKey = try {
            let textpri = String.fromUtf8(File.readFrom(privateKeyFile.getOrThrow()))
            RSAPrivateKey.decodeFromPem(textpri, password: password)
        } catch (_) {
            None
        }
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

    public init(privateKey: ?RSAPrivateKey, publicKey: ?RSAPublicKey) {
        this.rsaPublicKey = publicKey
        this.rsaPrivateKey = privateKey
    }
    public func getPublicKey(): RSAPublicKey {
        rsaPublicKey.getOrThrow()
    }
    public func getPrivateKey(): RSAPrivateKey {
        rsaPrivateKey.getOrThrow()
    }
}
