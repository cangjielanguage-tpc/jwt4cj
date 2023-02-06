// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from jwt import jwt.algorithms.*
from jwt import jwt.interfaces.*
from jwt import jwt.exception.*
from jwt import jwt.*

main() {
    var noa = Algorithm.none()
    let ret: Array<UInt8> = noa.sign("0123456789".toUtf8Array(), "ABCDEF".toUtf8Array())
    let token = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.MEUCIDyeCSbxc2rZ8qWg01aIEVxgIAoKFTj3kZOL4rRonuHxAiEAscdWHtaNHFu5GlWmkY0HQruaxyCJSFi4wJGsftUM0LI"
    var jd = JWTDecoder(token)
    try {
        noa.verify(jd)
    } catch (e: SignatureVerificationException) {
        return 0
    }
    return 1
}
