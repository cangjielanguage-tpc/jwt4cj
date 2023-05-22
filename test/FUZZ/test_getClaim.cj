// 3rd_party_lib:jwt4cj/build/jwt4cj
// 3rd_party_lib:jwt4cj/ci_lib/cryptocj

from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.utils.*
from jwt4cj import jwt.interfaces.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*

from std import collection.*
from std import time.*
from encoding import json.*
from std import os.posix.*
from std import fs.*
import secodeFuzz.*
from std import unittest.*
from std import unittest.testmacro.*
from std import collection.ArrayList


func call_fuzz(name:String){
    let jwtBuilder :Builder = JWT.create()
    jwtBuilder.withClaim(name,true)
    var jwtStr = jwtBuilder.sign(Algorithm.none()) 
    let jwtDecoder = JWTDecoder(jwtStr)
    // public func getClaim(name: String): Claim
    jwtDecoder.getClaim(name)
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_JWTDecoder.getClaim")
    unsafe{
        DT_FUZZ_String(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}