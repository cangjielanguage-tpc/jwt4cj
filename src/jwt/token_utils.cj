package jwt

import jwt.exception.*

abstract class TokenUtils {

    static func splitToken(token: String): Array<String> {
        var delimiter: Char = '.'
        let firstPeriodIndex: Int64 = token.indexOf(delimiter).getOrThrow()
        if (firstPeriodIndex == -1) {
            throw wrongNumberOfParts(0)
        }
        let secondPeriodIndex: Int64 = token.indexOf(delimiter, firstPeriodIndex + 1).getOrThrow()
        if (secondPeriodIndex == -1) {
            throw wrongNumberOfParts(2)
        }
        if (token.indexOf(delimiter, secondPeriodIndex + 1).getOrThrow() != -1) {
            throw wrongNumberOfParts("> 3")
        }

        var parts: Array<String> = Array<String>(3, item: "")
        parts[0] = token[..firstPeriodIndex]
        parts[1] = token[(firstPeriodIndex + 1)..secondPeriodIndex]
        parts[2] = token[secondPeriodIndex..]

        return parts
    }

    private static func wrongNumberOfParts(partCount: Any): JWTDecodeException {
        return JWTDecodeException("The token was expected to have 3 parts, but got %s.")
    }
}
