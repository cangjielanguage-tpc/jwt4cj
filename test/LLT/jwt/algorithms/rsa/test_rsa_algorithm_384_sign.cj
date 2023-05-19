// DEPENDENCE: test_rsa_privateKey_02.pem
// DEPENDENCE: test_rsa_publicKey_02.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.interfaces.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*
from jwt4cj import jwt.utils.*
from cryptocj import rsacj.*
from std import os.posix.*
from std import fs.*

main() {

    let src: Array<UInt8> = "eyJhbGciOiJSUzM4NCIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0".toUtf8Array()
    let src_header: Array<UInt8> = "eyJhbGciOiJSUzM4NCIsInR5cCI6IkpXVCJ9".toUtf8Array()
    let src_payload: Array<UInt8> = "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0".toUtf8Array()
    var path: String = getcwd()
    let pri_key: String = "${path}/test_rsa_privateKey_02.pem"
    let pub_key: String = "${path}/test_rsa_publicKey_02.pem"
    var rsa = Algorithm.RSA384(RSAKeyProviderFileImpl(pri_key))
    var rsa2 = Algorithm.RSA384(RSAKeyProviderFileImpl(pri_key, pub_key))
    let ret = rsa.sign(src)
    let ret2 = rsa2.sign(src_header, src_payload)
    if (Base64Util.urlEncode(ret) == Base64Util.urlEncode(ret2)) {
        println("签名后的值为:" + "${Base64Util.urlEncode(ret)}")
        println("两种方式的签名结果是一致的..")
        return 0
    }
    return 1
}
