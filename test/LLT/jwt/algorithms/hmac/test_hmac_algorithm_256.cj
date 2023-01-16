// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt import jwt.algorithms.*
from encoding import hex.*
from cryptocj import hmaccj.*

main() {
    var hmac1 = Algorithm<Array<UInt8>>.HMAC256("test1280".toUtf8Array())
    var arr2: Array<UInt8> = hmac1.sign("0123456789ABCDEF".toUtf8Array())
    if (toHexString(arr2) != "b75ddc670bb8c75296d3207bfa8549df81ba3ef33500593c9d644a03dbcc1e0d") {
        -1
    }
    0
}
