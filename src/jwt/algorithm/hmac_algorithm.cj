package jwt.algorithm

//from crypto import enc.*
from encoding import base64.*

public class HmacAlgorithm <: Algorithm {
    private var secret: String

    init(name: String, description: String, secret: String) {
        super(name, description)
        this.secret = secret
    }

    public static func HMAC256(secret: String): Algorithm {
        return HmacAlgorithm("HS256", "HmacSHA256", secret);
    }



    public func sign(content: Array<UInt8>): Array<UInt8> {
        // var sign: String = HMac.hmacSHA256(secret.toUtf8Array(), data)
        return Array<UInt8>(20, {i => UInt8(97 + i)})
    }

   public func verify(content: Array<UInt8>): Array<UInt8> {
        return sign(content)
    }
}