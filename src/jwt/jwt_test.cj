package jwt

from std import unittest.*//testfame
from std import unittest.testmacro.*//macro_Defintion

import jwt.algorithm.*


@Test
public class JWTest {

    @TestCase
    func testDecodeJWT(): Unit {

        let jwt: DecodeJWT = JWT.decode("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.UQmqAUhUrpDVV2ST7mZKyLTomVfg7sYkEjmdDI5XF8Q")
        println(jwt.getHeader().toString())
        println(jwt.getPayload().toString())

        @Assert("jwt", jwt.getHeader().getType())
    }



    @TestCase
    func testEncodeJWT(): Unit {

        var payload: Map<String, JsonValue> = HashMap<String, JsonValue>()
        println(payload.size())
        
        let builder: JWTBuilder = JWT.builder()
        builder.withIssuer("clzytech").withClaim("url", "http://baidu.com-+_").withSubject("test").withAudience("tangxin").withExpiresAt(Time.now().nanosecond()).withNotBefore(Time.now())
        let jwt: DecodeJWT = builder.sign(Base64Algorithm())


        @Assert("ZXdvZ0lDSmhiR2NpT2lBaVFtRnpaVFkwSWl3S0lDQWlkSGx3SWpvZ0lrcFhWQ0lLZlE9PS5ld29nSUNKcGMzTWlPaUFpWTJ4NmVYUmxZMmdpTEFvZ0lDSjFjbXdpT2lBaWFIUjBjRG92TDJKaGFXUjFMbU52YlMwclh5SXNDaUFnSW5OMVlpSTZJQ0owWlhOMElpd0tJQ0FpWVhWa0lqb2dJblJoYm1kNGFXNGlMQW9nSUNKaGJHY2lPaUExTkRnM05UazRNRFVzQ2lBZ0ltNWlaaUk2SURVME9EYzJNRGcwTmdwOQ==", jwt.getSignature())
    }
}
