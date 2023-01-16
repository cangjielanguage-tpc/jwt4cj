package jwt.impl

import jwt.common.HeaderParams
import jwt.interfaces.Header
import jwt.impl.json.Deserializer

public class HeaderDeserializer <: Deserializer {
    public func doDeserialize(jsonStr: String): Header {
        let map = super.deserialize(jsonStr)
        let algorithm: ?String = map.get(HeaderParams.ALGORITHM)?.asString()
        let typ: ?String = map.get(HeaderParams.TYPE)?.asString()
        let contentType: ?String = map.get(HeaderParams.CONTENT_TYPE)?.asString()
        let keyId: ?String = map.get(HeaderParams.KEY_ID)?.asString()
        BaseHeader(algorithm, typ, contentType, keyId, map)
    }
}
