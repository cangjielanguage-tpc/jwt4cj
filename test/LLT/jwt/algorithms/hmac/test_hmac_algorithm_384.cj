// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt4cj import jwt.algorithms.*
from encoding import hex.*
from cryptocj import hmaccj.*

main() {
    var hmac1 = Algorithm.HMAC384("test1280".toUtf8Array())
    var arr2: Array<UInt8> = hmac1.sign("0123456789ABCDEF".toUtf8Array())
    if (toHexString(arr2) != "809f4653a5cc87ac82eaf3b95d7351406034198c13353b6c6cab8878c3ea2f1c607d5593b635e2d9718e95ba900f2939") {
        -1
    }
    0
}
