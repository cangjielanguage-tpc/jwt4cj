package jwt.algorithm

import jwt.interfaces.*
import jwt.exception.SignatureVerificationException

public abstract class Algorithm <: ToString & Equatable<Algorithm> {
    
    private var name: String;
    private var description: String;

    init() {
        this.name = "none"
        this.description = "none"
    }

    init(name: String, description: String) {
        this.name = name
        this.description = description
    }

    public static func None(): Algorithm {
        return NoneAlgorithm()
    }

    public func setName(name: String) {
        this.name = name
    }

    public func getName(): String {
        return this.name
    }

    public func setDescription(description: String) {
        this.description = description
    }

    public func getDescription(): String {
        return this.description
    }

    public func verify(content: Array<UInt8>, signature: Array<UInt8>): Unit {
        let verify = verify(content)
        println(verify)
        println(signature)
        if (verify.size() != signature.size()) {
            throw SignatureVerificationException("The Token's Signature resulted invalid when verified using the Algorithm: " + this.toString())
        }
        for (i in 0..verify.size()) {
            if (signature[i] != verify[i]) {
                throw SignatureVerificationException("The Token's Signature resulted invalid when verified using the Algorithm: " + this.toString())
            }
        }
    }

    public func sign(content: Array<UInt8>): Array<UInt8>


    public func verify(content: Array<UInt8>): Array<UInt8>


    public func toString(): String {
        return this.name
    }

    public operator func ==(algorithm: Algorithm): Bool {
        return this.name.equals(algorithm.getName())
    }

    public operator func !=(algorithm: Algorithm): Bool {
        return !(this ==(algorithm))
    }

}