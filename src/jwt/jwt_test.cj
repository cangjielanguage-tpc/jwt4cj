package jwt

from std import unittest.*//testfame
from std import unittest.testmacro.*//macro_Defintion


@Test
func testDecodeJWT(): Unit {

    let jwt: DecodeJWT = JWT.decode("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.UQmqAUhUrpDVV2ST7mZKyLTomVfg7sYkEjmdDI5XF8Q")
    println(jwt.getHeader().toString())
    println(jwt.getPayload().toString())

    @Assert("jwt", jwt.getHeader().getType())
}



@Test
func testEncodeJWT(): Unit {

    var payload: Map<String, JsonValue> = HashMap<String, JsonValue>()
    println(payload.size())
    
    let builder: JWTBuilder = JWT.builder()
    builder.withIssuer("clzytech").withClaim("url", "http://baidu.com-+_").withSubject("test").withAudience("tangxin").withExpiresAt(Time.now().nanosecond()).withNotBefore(Time.now())
    let token: String = builder.sign(HmacAlgorithm.HMAC256("secert"))


    @Assert("token", token)
}