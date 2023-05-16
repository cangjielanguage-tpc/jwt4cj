// DEPENDENCE: test_rsa_privateKey.pem
// DEPENDENCE: test_rsa_publicKey.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from jwt import jwt.algorithms.*
from jwt import jwt.interfaces.*
from jwt import jwt.impl.*
from jwt import jwt.*
from jwt import jwt.utils.*
from cryptocj import rsacj.*
from std import os.posix.*
from std import fs.*
from std import unittest.*
from std import unittest.testmacro.*

main() {
    let header = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9"
    let payload = "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ"
    let secret = "Q_CatS3ATEdvyR_T_jCFVDzVSJKWZpi5xYScdji3D6JBY335_AjanEzJFERNKO-d1KVs8Rx2xyNm6N_fI8y1Fg"
    let token = "${header}.${payload}.${secret}"
    let src: Array<UInt8> = "${header}.${payload}".toUtf8Array()

    var path: String = getcwd()
    let pri_key: String = "${path}/test_rsa_privateKey.pem"
    let pub_key: String = "${path}/test_rsa_publicKey.pem"

    let prikey: KeyType = MyKeyType({ => pri_key})
    let pubkey: KeyType = MyKeyType({ => pub_key})
    let kp: KeyProvider<KeyType, KeyType> = RSAKeyProviderFileImpl(prikey, pubkey)

    let rsa = Algorithm.RSA256(kp)
    let signResBytes = rsa.sign(src)
    let signresStr = Base64Util.urlEncode(signResBytes)
    println(signresStr)
    println(secret)
    @Assert(signresStr, secret)

    let jd = JWTDecoder(token)
    rsa.verify(jd)

    0
}

class MyKeyType <: KeyType {
    let getter: () -> String
    init(getter: () -> String) {
        this.getter = getter
    }
    public override func getKeyFilePath(): String {
        return getter()
    }
}
