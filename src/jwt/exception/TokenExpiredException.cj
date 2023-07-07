package jwt.exception

from std import time.*

public class TokenExpiredException <: JWTVerificationException {
    private var time: DateTime

    public init(message: String, time: DateTime) {
        super(message)
        this.time = time
    }

    public func getExpiredOn(): DateTime {
        return this.time
    }
}
