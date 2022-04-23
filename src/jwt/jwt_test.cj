package jwt

from std import unittest.*//testfame
from std import unittest.testmacro.*//macro_Defintion

import jwt.algorithm.*


@Test
public class JWTest {

    @TestCase
    func testDecodeJWT(): Unit {

        let jwt: DecodeJWT = JWT.decode("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.UQmqAUhUrpDVV2ST7mZKyLTomVfg7sYkEjmdDI5XF8Q")
        // println(jwt.getHeader().toString())
        // println(jwt.getPayload().toString())

        @Assert("jwt", jwt.getHeader().getType())
    }



    @TestCase
    func testEncodeJWT(): Unit {

        var payload: Map<String, JsonValue> = HashMap<String, JsonValue>()
        // println(payload.size())
        
        let builder: JWTBuilder = JWT.builder()
        builder.withIssuer("clzytech").withClaim("url", "http://baidu.com-+_").withSubject("test").withAudience("tangxin")
        let jwt: DecodeJWT = builder.sign(Base64Algorithm())

        println(jwt.getToken())
        @Assert("ZXdvZ0lDSmhiR2NpT2lBaVFtRnpaVFkwSWl3S0lDQWlkSGx3SWpvZ0lrcFhWQ0lLZlEuZXdvZ0lDSnBjM01pT2lBaVkyeDZlWFJsWTJnaUxBb2dJQ0oxY213aU9pQWlhSFIwY0RvdkwySmhhV1IxTG1OdmJTMHJYeUlzQ2lBZ0luTjFZaUk2SUNKMFpYTjBJaXdLSUNBaVlYVmtJam9nSW5SaGJtZDRhVzRpQ24w", jwt.getSignature())
    }

    @TestCase
    func testValidatorJWT(): Unit {
        JWT.verify("ewogICJhbGciOiAiQmFzZTY0IiwKICAidHlwIjogIkpXVCIKfQ==.ewogICJpc3MiOiAiY2x6eXRlY2giLAogICJ1cmwiOiAiaHR0cDovL2JhaWR1LmNvbS0rXyIsCiAgInN1YiI6ICJ0ZXN0IiwKICAiYXVkIjogInRhbmd4aW4iCn0=.ZXdvZ0lDSmhiR2NpT2lBaVFtRnpaVFkwSWl3S0lDQWlkSGx3SWpvZ0lrcFhWQ0lLZlE9PS5ld29nSUNKcGMzTWlPaUFpWTJ4NmVYUmxZMmdpTEFvZ0lDSjFjbXdpT2lBaWFIUjBjRG92TDJKaGFXUjFMbU52YlMwclh5SXNDaUFnSW5OMVlpSTZJQ0owWlhOMElpd0tJQ0FpWVhWa0lqb2dJblJoYm1kNGFXNGlDbjA9", Base64Algorithm())

        @Assert("1", "1")
    }
}
