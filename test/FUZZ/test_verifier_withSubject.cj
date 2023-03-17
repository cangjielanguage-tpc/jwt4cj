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


func call_fuzz(subject:String){
    let jwtBuilder :Builder = JWT.create()
    jwtBuilder.withSubject(subject)
    var jwtStr = jwtBuilder.sign(Algorithm.none()) 
    let require = JWT.require(Algorithm.none())
    require.withSubject(subject)
    return
}

func unboundTest():Unit{
    var case_name = CString("Fuzz_BaseVerification.withSubject")
    unsafe{
        DT_FUZZ_String(0,30000000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}