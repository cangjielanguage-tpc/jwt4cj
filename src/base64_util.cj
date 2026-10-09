/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package jwt4cj

public class Base64Util {
    public static func urlEncode(content: Array<UInt8>): String {
        return toUrlSafe(toBase64String(content))
    }

    public static func urlEncode(content: String): String {
        return toUrlSafe(toBase64String(content.toArray()))
    }

    public static func urlDecode2Byte(content: String): Array<UInt8> {
        return fromBase64String(fromUrlSafe(content)).getOrThrow()
    }

    public static func urlDecode(content: String): String {
        return String.fromUtf8(fromBase64String(fromUrlSafe(content)).getOrThrow())
    }

    // 单遍把标准 base64 转成 url-safe('+'->'-'、'/'->'_'、去掉 '=')，只分配一个结果串
    private static func toUrlSafe(stdB64: String): String {
        let src = stdB64.toArray()
        let out = Array<UInt8>(src.size, repeat: 0)
        var n = 0
        for (i in 0..src.size) {
            let c = src[i]
            if (c == b'=') {
                continue
            }
            if (c == b'+') {
                out[n] = b'-'
            } else if (c == b'/') {
                out[n] = b'_'
            } else {
                out[n] = c
            }
            n++
        }
        return unsafe { String.fromUtf8Unchecked(out[0..n]) }
    }

    // 单遍把 url-safe 还原为标准 base64 并补齐 '='，只分配一个结果串
    private static func fromUrlSafe(urlB64: String): String {
        let src = urlB64.toArray()
        let pad = (4 - src.size) & 3
        let out = Array<UInt8>(src.size + pad, repeat: b'=')
        for (i in 0..src.size) {
            let c = src[i]
            if (c == b'-') {
                out[i] = b'+'
            } else if (c == b'_') {
                out[i] = b'/'
            } else {
                out[i] = c
            }
        }
        return unsafe { String.fromUtf8Unchecked(out) }
    }
}
