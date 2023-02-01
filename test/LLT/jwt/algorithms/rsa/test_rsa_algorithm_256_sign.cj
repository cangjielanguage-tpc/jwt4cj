// DEPENDENCE: test_rsa_privateKey.pem
// DEPENDENCE: test_rsa_publicKey.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from jwt import jwt.algorithms.*
from jwt import jwt.interfaces.*
from jwt import jwt.*
from jwt import jwt.utils.*
from cryptocj import rsacj.*
from std import os.posix.*
from std import fs.*

main() {

    let token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.A0NsGblfMb1Kz2QhrR5ExYkIsqk-iuVM1Zynd1rewXuR9UEkk7hIMsfGJAVvNp05w0h8uH0weq6N_x7NNJaaGBqrHQO49oc4YviuXIaJhNO2X71qpAaZQ6wKRNuyZ7sXD2BKYiDtBVcvBY1-GSsDhQ4YDGucIdoADzys89Ao5tbg-3KDD0QJfDXaTPJUUqA7zKVluAkMUHTmvaYkL0UfNS_buVBV5GOSRCJU2uLo1uTv1YjEubANGoDr10ZqFhmJfxWsgpJA6M5hdfXWIW8VOBFODn6afS0QgMDcW2s2sUTz-s2Kkbohke6Vi32MGyGlJJ9N6bFRl_FIPKgYNAx0sA"
    let src: Array<UInt8> = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ".toUtf8Array()
    let src_header: Array<UInt8> = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9".toUtf8Array()
    let src_payload: Array<UInt8> = "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ".toUtf8Array()
    var path: String = getcwd()
    let pri_key: String = "${path}/test_rsa_privateKey.pem"
    let pub_key: String = "${path}/test_rsa_publicKey.pem"
    var rsa = Algorithm.RSA256(pri_key)
    var rsa2 = Algorithm.RSA256(pri_key, Array<UInt8>())
    let ret = rsa.sign(src)
    let ret2 = rsa.sign(src_header, src_payload)
    if (Base64Util.urlEncode(ret) == Base64Util.urlEncode(ret2)) {
        println("签名后的值为:" + "${Base64Util.urlEncode(ret)}")
        println("两种方式的签名结果是一致的..")
        return 0
    }
    return 1
}
