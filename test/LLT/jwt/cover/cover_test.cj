// DEPENDENCE: ../algorithms/rsa/test_rsa_privateKey_02.pem
// DEPENDENCE: ../algorithms/rsa/test_rsa_publicKey_02.pem
// DEPENDENCE: ../algorithms/ecdsa/test_ecdsa_privateKey.pem
// DEPENDENCE: ../algorithms/ecdsa/test_ecdsa_publicKey.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.impl.json.*
from jwt4cj import jwt.*
from encoding import json.*
from std import collection.*
from std import time.*
from crypto4cj import eccj.*

main() {
    println(JsonNodeClaim(JsonValue.fromStr("null")).isNull())
    println(JsonNodeClaim(JsonValue.fromStr("1")).asInt())
    println(JsonNodeClaim(JsonValue.fromStr("1.1")).asFloat())
    println(JsonNodeClaim(JsonValue.fromStr(##"["a0"]"##)).asArray()[0])
    println(JsonNodeClaim(JsonValue.fromStr(##"["l0"]"##)).asList()[0])
    println(JsonNodeClaim(JsonValue.fromStr(##"{"k":"v"}"##)).asMap().get("k").toString())
    println(JsonNodeClaim(JsonValue.fromStr("123")).getValue())

    println(asIntList(JsonNodeClaim(JsonValue.fromStr(##"[1,2,4]"##))).size)
    println(asStringList(JsonNodeClaim(JsonValue.fromStr(##"["a","b"]"##))).size)

    println(Algorithm.none().getName())
    let rsaKey = RSAKeyProviderFileImpl("test_rsa_privateKey_02.pem", "test_rsa_publicKey_02.pem")
    println("rsaKey.getPrivateKey().getPrivateKey() : ${rsaKey.getPrivateKey().getPrivateKey()}")
    println("rsaKey.getPrivateKey().getPublicKey() : ${rsaKey.getPrivateKey().getPublicKey()}")
    println("rsaKey.getPublicKey().getPublicKey() : ${rsaKey.getPublicKey().getPublicKey()}")
    let ecKey = ECDSAKeyProviderFileImpl("test_ecdsa_privateKey.pem", "test_ecdsa_publicKey.pem")
    println(ecKey.getPrivateKey().getSize())
    println(ecKey.getPublicKey().getCurveName())

    let ecPrivateKey = EC.readPriKeyfromFile("test_ecdsa_privateKey.pem")
    let ecPublicKey = EC.readPubKeyfromFile("test_ecdsa_publicKey.pem")
    let ecKey1 = ECDSAKeyProviderImpl(ecPrivateKey, ecPublicKey)
    println(ecKey1.getPrivateKey().getSize())
    println(ecKey1.getPublicKey().getCurveName())
    0
}
