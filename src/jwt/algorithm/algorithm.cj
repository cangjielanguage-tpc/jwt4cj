package jwt.algorithm

import jwt.interfaces.*

public abstract class Algorithm {
    
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

    public func verify(content: Array<UInt8>, signature: Array<UInt8>): Bool {
         let verify = verify(content)
        if (verify.size() == signature.size()) {
            for (i in 0..verify.size()) {
                if (signature[i] != verify[i]) {
                    return false
                }
            }
            return true
        }
        return false
    }

    public func sign(content: Array<UInt8>): Array<UInt8>


    public func verify(content: Array<UInt8>): Array<UInt8>

}