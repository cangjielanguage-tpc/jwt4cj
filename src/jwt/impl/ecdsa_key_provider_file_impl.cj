package jwt.impl

public class ECDSAKeyProviderFileImpl <: ECDSAKeyProvider<String, String> {

    private var publicKeyFile: String
    private var privateKeyFile: String

    public init(file: String) {
        this.publicKeyFile = file
        this.privateKeyFile = file
    }

    public init(privateKeyFile: String, publicKeyFile: String) {
        this.privateKeyFile = privateKeyFile
        this.publicKeyFile = publicKeyFile
    }

    public func getPublicKey(): String {
        return publicKeyFile
    }

    public func getPrivateKey(): String {
        return privateKeyFile
    }

}
