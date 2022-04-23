package jwt.impl

from encoding import json.*
from std import collection.*

import jwt.interfaces.*
import jwt.utils.Base64Util


public class JWTParser {


    public static func parseHeader(header: String): Header {
        // println(header.toString())
        return BaseHeader.deserialize(DataModel.fromJson(JsonValue.fromStr(base64UrlDecode(header))))
    }

    public static func parsePayload(payload: String): Payload {
        // println(JsonValue.fromStr(base64UrlDecode(payload)))
        return BasePayload.deserialize(DataModel.fromJson(JsonValue.fromStr(base64UrlDecode(payload))))
    }


    private static func base64UrlDecode(encoded: String): String {
        return String.fromUtf8(Base64Util.urlDecode(encoded))
    }

    private static func base64UrlEncode(decoded: String): String {
        return Base64Util.urlEncode(decoded.toUtf8Array())
    }
}