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
        Array<String>(
            3,
            {
                i: Int64 => match (i) {
                    case 0 => token[..firstPeriodIndex]
                    case 1 => token[(firstPeriodIndex + 1)..secondPeriodIndex]
                    case 2 => token[secondPeriodIndex..]
                    case _ => ""
                }
            }
        )
    }

    private static func wrongNumberOfParts(partCount: ToString) {
        JWTDecodeException("The token was expected to have 3 parts, but got ${partCount}.")
    }
}
