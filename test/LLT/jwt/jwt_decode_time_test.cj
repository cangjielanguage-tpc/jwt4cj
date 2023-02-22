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
