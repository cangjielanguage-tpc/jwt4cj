package jwt.impl

import jwt.common.HeaderParams
import jwt.impl.json.Deserializer

public class HeaderDeserializer <: Deserializer {
    func doDeserialize(jsonStr: String): Header {
        let map = super.deserialize(jsonStr)
        let algorithm: ?String = asString(HeaderParams.ALGORITHM, map)
        let typ: ?String = asString(HeaderParams.TYPE, map)
        let contentType: ?String = asString(HeaderParams.CONTENT_TYPE, map)
        let keyId: ?String = asString(HeaderParams.KEY_ID, map)
        BaseHeader(algorithm, typ, contentType, keyId, map)
    }
}
