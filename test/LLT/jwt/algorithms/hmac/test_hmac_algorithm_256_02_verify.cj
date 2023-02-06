// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import collection.*
from jwt import jwt.algorithms.*
from jwt import jwt.utils.*
from jwt import jwt.interfaces.*
from jwt import jwt.*
from cryptocj import hmaccj.*

main() {
    let hmac = Algorithm.HMAC256("pri_key")
    let token = "ewogICJrMSI6ICJ2MSIsCiAgImtpZCI6ICJrZXlJZCIsCiAgImFsZyI6ICJIUzI1NiIsCiAgInR5cCI6ICJKV1QiCn0.ewogICJpc3MiOiAiaXNzdWVyIiwKICAic3ViIjogInN1YmplY3QiLAogICJhdWQiOiBbCiAgICAiYXVkMSIsCiAgICAiYXVkMiIKICBdLAogICJleHAiOiAzNjczODM1MDUwLAogICJuYmYiOiAxNjczODM1MDUwLAogICJpYXQiOiAxNjczODM1MDAwLAogICJqdGkiOiAiand0SWQiLAogICJib29sIjogdHJ1ZSwKICAiZGRkIjogImRmZGRkZmYiLAogICJpbnQ2NCI6IDY0LAogICJmbG9hdDY0IjogMy4xNDAwMDAsCiAgIlN0cmluZyI6ICJhYmFhYmEiLAogICJ0aW1lIjogMTY3Mzg1MDAwMCwKICAibWFwIjogewogICAgIm1rMiI6ICJtdjIiCiAgfSwKICAibGlzdCI6IFsKICAgIDU2LjUxMDAwMCwKICAgIDQxLjk2MDAwMAogIF0sCiAgIm51bGwiOiBudWxsLAogICJhcnJheXN0cmluZyI6IFsKICAgICJhc3RyMSIsCiAgICAiYXN0cjIiCiAgXSwKICAiYXJyYXlpbnQiOiBbCiAgICA2ODQsCiAgICA2NAogIF0sCiAgInBrMSI6ICJwdjEiLAogICJwazIiOiAicHYyIgp9._GxKVIXindFq74cpZG1ulrFkw7yqsowMnZZ47nNPDRg"
    let jd = JWTDecoder(token)
    hmac.verify(jd)
    println("verify success")
    0
}
