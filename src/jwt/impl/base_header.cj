package jwt.impl

from encoding import json.*
from serialization import serialization.*

import jwt.interfaces.*

public class BaseHeader <: Header & Serializable<Header> {

    private var algorithm: String
    private var `type`: String
    private var contentType: String = ""

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

    public func getContentType(): String {
        return this.contentType
    }


    public func toString(): String {
        return this.serialize().toJson().toString()
    }


    public func serialize(): DataModel {
        let dataModel = DataModelStruct().add(field<String>(PublicField.ALGORITHM, algorithm)).add(field<String> (PublicField.TYPE, `type`))
        if (contentType.size > 0) {
            dataModel.add(field<String>(PublicField.CONTENT_TYPE, contentType))
        }
        return dataModel
    }
    
    public static func deserialize(dm: DataModel): Header {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct") 
        }
        var result = BaseHeader(String.deserialize(dms.get(PublicField.ALGORITHM)))
        let contentType = String.deserialize(dms.get(PublicField.CONTENT_TYPE))
        if (contentType.size > 0) {
            result.contentType = contentType
        }
        return result
    }

}
