package jwt.utils

from encoding import base64.*

public class Base64Util {
    public static func urlEncode(content: Array<UInt8>): String {
        return toBase64String(content).replace("+", "-").replace("/", "_")
    }

    public static func urlEncode(content: String): String {
        return toBase64String(content.toUtf8Array()).replace("+", "-").replace("/", "_")
    }

    public static func urlDecode2Byte(content: String): Array<UInt8> {
        var c = content.replace("-", "+").replace("_", "/")
        return fromBase64String(c).getOrThrow()
    }

    public static func urlDecode(content: String): String {
        var c = content.replace("-", "+").replace("_", "/")
        return String.fromUtf8(fromBase64String(c).getOrThrow())
    }
}
