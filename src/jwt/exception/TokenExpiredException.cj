package jwt.exception

from std import time.*

public class TokenExpiredException <: JWTVerificationException {

    private var time: Time

    public init(message: String, time: Time) {
        super(message)
        this.time = time
    }

     public func getExpiredOn(): Time {
        return this.time
    }
}
