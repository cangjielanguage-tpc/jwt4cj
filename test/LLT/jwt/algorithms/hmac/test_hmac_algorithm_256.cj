// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt4cj import jwt.algorithms.*
from encoding import hex.*

main() {
    var hmac1 = Algorithm.HMAC256("test1280".toArray())
    var arr2: Array<UInt8> = hmac1.sign("0123456789ABCDEF".toArray())
    if (toHexString(arr2) != "b75ddc670bb8c75296d3207bfa8549df81ba3ef33500593c9d644a03dbcc1e0d") {
        return -1
    }
    return 0
}
