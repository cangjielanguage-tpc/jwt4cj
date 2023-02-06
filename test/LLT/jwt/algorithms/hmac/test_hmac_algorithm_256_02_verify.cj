// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt import jwt.algorithms.*
from jwt import jwt.utils.*
from jwt import jwt.interfaces.*
from jwt import jwt.*
from cryptocj import hmaccj.*

main() {
    let hmac = Algorithm.HMAC256("pri_key")
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.4uty5lnF7jPs-Davk-gPM1KQk8kjRpKu6557_QlYW-U"
    let jd = JWTDecoder(token)
    hmac.verify(jd)
    println("verify success")
    0
}
