// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from std import time.*
from encoding import json.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.exception.*
from jwt4cj import jwt.*
from jwt4cj import jwt.utils.*

let header = ###"{"alg": "none","typ": "JWT"}"###
let payload = ###"{"k1": "v1"}"###

main() {
    let hb64 = Base64Util.urlEncode(header)
    let pb64 = Base64Util.urlEncode(payload)
    let token = "${hb64}.${pb64}."
    let decoded = JWT().decodeJwt(token)
    if(decoded.getHeader() != hb64){
        return 1
    }
    if(decoded.getPayload() != pb64){
        return 2
    }
    0
}
