// 3rd_party_lib:jwt/build/jwt
// 3rd_party_lib:jwt/ci_lib/cryptocj

from jwt import jwt.algorithms.*
from jwt import jwt.utils.*
from jwt import jwt.interfaces.*
from jwt import jwt.impl.*
from jwt import jwt.*

from std import collection.*
from std import time.*
from encoding import json.*
from std import os.posix.*
from std import fs.*
import secodeFuzz.*
from std import unittest.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(value:Float64){
    let jwtBuilder :Builder = JWT.create()
    //public func withClaim(name: String, value: Float64): Builder
    jwtBuilder.withClaim("name_Claim",value)
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_JWTBuilder.withClaim")
    unsafe{
        DT_FUZZ_Float64(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}