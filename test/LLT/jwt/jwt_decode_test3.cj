// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.algorithms.*
from jwt import jwt.impl.*
from jwt import jwt.exception.*
from jwt import jwt.*
from jwt import jwt.utils.*

let header = ###"{"alg": "none","typ": "JWT"}"###
let payload = ###"{"k1": "v1"}"###

main() {
    let wrong = header + "}"
    let headerB64 = Base64Util.urlEncode(wrong)
    let payloadB64 = Base64Util.urlEncode(payload)
    let token = "${headerB64}.${payloadB64}."
    try {
        let decoder = JWT.decode(token)
    } catch (e: JWTDecodeException) {
        println(e.message)
        if (e.message == "The string '${wrong}' doesn't have a valid JSON format.") {
            return 0
        }
    }
    1
}
