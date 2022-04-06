package jwt.impl

from encoding import json.*
from std import serialization.*

import jwt.interfaces.*

public class BaseHeader <: Header {

    private var algorithm: String
    private var `type`: String

    public init(algorithm: String) {
        this("jwt", algorithm)
    }

    public init(`type`: String, algorithm: String) {
        this.`type` = `type`
        this.algorithm = algorithm
    }

    public func getAlgorithm(): String {
        return this.algorithm
    }


    public func getType(): String {
        return this.`type`
    }


    public func serialize(): DataModel {
        return DataModelStruct().add(field<String>("alg", algorithm)).add(field<String> ("typ", `type`))
    }
    
    public static func deserialize(dm: DataModel): Header {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct") 
        }
        var result = BaseHeader(String.deserialize(dms.get("alg")))
        return result
    }

}