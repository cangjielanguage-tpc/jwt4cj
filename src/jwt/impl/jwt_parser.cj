package jwt.impl

from encoding import json.*
from encoding import base64.*

import jwt.interfaces.*


public class JWTParser {


    public static func parseHeader(header: String): Header {
        let json: JsonObject = JsonValue.fromStr(base64UrlDecode(header)).asObject().getOrThrow()
        // println(json.toJsonString())
        let h = BaseHeader(json.get("alg").toString())
        return h
    }

    public static func parsePayload(payload: String): Payload {
        println(base64UrlDecode(payload))
        let json: JsonObject = JsonValue.fromStr(base64UrlDecode(payload)).asObject().getOrThrow()
        println(json.toJsonString())
        let p = BasePayload()
        
        return p
    }


    private static func base64UrlDecode(encoded: String): String {
        return String.fromUtf8(fromBase64String(encoded).getOrThrow())
    }

    private static func base64UrlEncode(decoded: String): String {
        return toBase64String(decoded.toUtf8Array())
    }
}