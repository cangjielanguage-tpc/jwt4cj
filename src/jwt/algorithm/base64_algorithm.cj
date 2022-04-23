package jwt.algorithm

//from crypto import enc.*
import jwt.utils.Base64Util

public class Base64Algorithm <: Algorithm {

    public init() {
        super("Base64", "Base64")
    }


    public func sign(content: Array<UInt8>): Array<UInt8> {
        return Base64Util.urlEncode(content).toUtf8Array()
    }

     public func verify(content: Array<UInt8>): Array<UInt8> {
         return sign(content)
     }

   
}