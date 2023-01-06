package jwt.utils

from encoding import base64.*

public class Base64Util {

    public static func urlEncode(content: Array<UInt8>): String {
        return toBase64String(content).replace("=", "").replace("+", "-").replace("/", "_")
    }


    public static func urlDecode(content: String): Array<UInt8> {
        var c = content.replace("-", "+").replace("_", "/")
        return fromBase64String(c).getOrThrow()
    }
}
