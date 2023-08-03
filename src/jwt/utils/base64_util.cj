package jwt.utils

from encoding import base64.*

public class Base64Util {
    public static func urlEncode(content: Array<UInt8>): String {
        return toBase64String(content).replace("+", "-").replace("/", "_").replace("=", "")
    }

    public static func urlEncode(content: String): String {
        return toBase64String(content.toUtf8Array()).replace("+", "-").replace("/", "_").replace("=", "")
    }

    public static func urlDecode2Byte(content: String): Array<UInt8> {
        var c = content.replace("-", "+").replace("_", "/")
        for (_ in 0..4 - c.size & 3) {c += '='}
        return fromBase64String(c).getOrThrow()
    }

    public static func urlDecode(content: String): String {
        var c = content.replace("-", "+").replace("_", "/")
        for (_ in 0..4 - c.size & 3) {c += '='}
        return String.fromUtf8(fromBase64String(c).getOrThrow())
    }
}
