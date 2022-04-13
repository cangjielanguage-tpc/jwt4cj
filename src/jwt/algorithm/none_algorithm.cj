package jwt.algorithm

public class NoneAlgorithm <: Algorithm {

    public init() {
        super("none", "none")
    }

    public func sign(content: Array<UInt8>): Array<UInt8> {
        return content
    }

    public func verify(jwt: DecodeJWT): Unit {
        
    }

}