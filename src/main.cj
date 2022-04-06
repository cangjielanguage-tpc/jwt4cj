
import jwt.*
import jwt.interfaces.*

func main() {
    let jwt: DecodeJWT = JWT.decode("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.UQmqAUhUrpDVV2ST7mZKyLTomVfg7sYkEjmdDI5XF8Q")
    println(jwt.getHeader().toString())
    println(jwt.getPayload().toString())
}