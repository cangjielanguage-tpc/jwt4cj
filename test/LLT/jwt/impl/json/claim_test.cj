// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from encoding import json.*
from jwt4cj import jwt.impl.json.*
from jwt4cj import jwt.exception.*

main() {
    try {
        MISSING_CLAIM.toString()
    } catch (e: MissingClaimException) {
        return 0
    }
    1
}
