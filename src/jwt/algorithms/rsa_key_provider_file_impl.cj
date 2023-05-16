package jwt.algorithms

public class RSAKeyProviderFileImpl <: RSAKeyProvider<KeyType, KeyType> {

    private var publicKeyFile: KeyType
    private var privateKeyFile: KeyType

    public init(filePath: String) {
        let key = KeyType(filePath)
        this.publicKeyFile = key
        this.privateKeyFile = key
    }

    public init(privateKeyFile: String, publicKeyFile: String) {
        this.privateKeyFile = KeyType(privateKeyFile)
        this.publicKeyFile = KeyType(publicKeyFile)
    }

    public init(privateKey: KeyType, publicKey: KeyType) {
        this.privateKeyFile = privateKey
        this.publicKeyFile = publicKey
    }
    
    public func getPublicKey(): KeyType {
        return publicKeyFile
    }

    public func getPrivateKey(): KeyType {
        return privateKeyFile
    }

}
