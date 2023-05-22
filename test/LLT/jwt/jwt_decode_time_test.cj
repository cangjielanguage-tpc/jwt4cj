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

main() {
    let token = JWT.create().withClaim("iat", "123").sign(Algorithm.none())
    try {
        let d = JWT.decode(token)
        println(d.getIssuedAt())
    } catch (e: JWTDecodeException) {
        if (e.message == "The claim 'iat' is not time.") {
            return 0
        }
        e.printStackTrace()
    }
    1
}
