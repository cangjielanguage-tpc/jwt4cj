// DEPENDENCE: test_rsa_privateKey.pem
// DEPENDENCE: test_rsa_publicKey.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import fs.*
from std import os.posix.*
from crypto4cj import rsacj.*
from crypto4cj import sha256cj.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.interfaces.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.utils.*
from jwt4cj import jwt.*

main() {

    let path: String = getcwd()
    // let pri_key: String = "${path}/test_rsa_privateKey.pem"
    let pub_key: String = "${path}/test_rsa_publicKey.pem"
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.Q_CatS3ATEdvyR_T_jCFVDzVSJKWZpi5xYScdji3D6JBY335_AjanEzJFERNKO-d1KVs8Rx2xyNm6N_fI8y1Fg"
    let rsa = Algorithm.RSA256(RSAKeyProviderFileImpl(pub_key))
    var jd = JWTDecoder(token)
    rsa.verify(jd)
    println("verify success")
    return 0
}
