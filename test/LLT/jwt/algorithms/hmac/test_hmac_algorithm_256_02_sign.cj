// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt import jwt.algorithms.*
from jwt import jwt.utils.*
from cryptocj import hmaccj.*

main() {
    let hmac1 = Algorithm.HMAC256("pri_key")
    let hmac2 = Algorithm.HMAC384("")
    let hmac3 = Algorithm.HMAC512("pri")
    let header: Array<UInt8> = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9".toUtf8Array()
    let payload: Array<UInt8> = "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ".toUtf8Array()
    var ret: Array<UInt8> = hmac1.sign(header, payload)
    hmac2.sign(header, payload)
    hmac3.sign(header, payload)
    println(Base64Util.urlEncode(ret))
    0
}
