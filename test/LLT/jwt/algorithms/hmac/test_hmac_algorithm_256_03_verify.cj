// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.utils.*
from jwt4cj import jwt.interfaces.*
from jwt4cj import jwt.*
from jwt4cj import jwt.exception.*
from cryptocj import hmaccj.*

main() {
    let hmac = Algorithm.HMAC256("pri_key")
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.brtr31I4r5EjJOtSTx41_Jwby4ZcoxhGfm4KswEcWP"
    let jd = JWTDecoder(token)
    try {
        hmac.verify(jd)
    } catch (e: SignatureVerificationException) {
        return 0
    }
    return 1
}
