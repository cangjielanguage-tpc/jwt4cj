// DEPENDENCE: test_ecdsa_privateKey.pem
// DEPENDENCE: test_ecdsa_publicKey.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import os.posix.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.interfaces.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*
from jwt4cj import jwt.utils.*

main() {
    var path: String = getcwd()
    let pri_key: String = "${path}/test_ecdsa_privateKey.pem"
    let pub_key: String = "${path}/test_ecdsa_publicKey.pem"
    let ec = Algorithm.ECDSA256(ECDSAKeyProviderFileImpl(pri_key, pub_key))
    let token = JWT.create().sign(ec)
    println(token)
    JWT.require(ec).build().verify(token)
    try {
        JWT.require(ec).build().verify(token + "1")
        return 1
    } catch (e: Exception) {
        println(e.message)
    }
    return 0
}
