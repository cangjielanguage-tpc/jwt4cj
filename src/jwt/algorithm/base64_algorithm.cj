package jwt.algorithm

//from crypto import enc.*

public class Base64Algorithm <: Algorithm {

    public init() {
        super("Base64", "Base64")
    }


    public func sign(content: Array<UInt8>): Array<UInt8> {
        return toBase64String(content).toUtf8Array()
    }

     public func verify(content: Array<UInt8>): Array<UInt8> {
         return sign(content)
     }

   
}