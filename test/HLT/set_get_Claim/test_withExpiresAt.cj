// 3rd_party_lib:jwt4cj/build/jwt4cj
// 3rd_party_lib:jwt4cj/ci_lib/cryptocj
//dependence:../utils_test/createsourcedata.cj

from jwt4cj import jwt.algorithms.*
from jwt4cj import jwt.utils.*
from jwt4cj import jwt.interfaces.*
from jwt4cj import jwt.impl.*
from jwt4cj import jwt.*
from cryptocj import hmaccj.*
from cryptocj import eccj.*
from cryptocj import rsacj.*

from std import unittest.*
from std import collection.*
from std import time.*
from encoding import json.*
from std import os.posix.*
from std import fs.*

/**
  public static func create(): Builder
  public func withExpiresAt(expiresAt: Time): Builder
  public func sign(algorithm: Algorithm): String
  public func getToken(): String
  public func getExpiresAt(): Time
*/

@Test
public class JWTTest {
    var returnTag: Int64 = -1
    var jwtStr:String = ""
    var strActual:String = ""
    let ins_1:SourceData = SourceData()
    let map_String:HashMap<String, Any> = ins_1.generateSourceDataWithString()[2]
    let arr_Str1:Array<Any> = ins_1.generateSourceDataWithString()[0]
    let map_Bool:HashMap<String, Any> = ins_1.generateSourceDataWithBool()[2]
    let entry:(ArrayList<String>,ArrayList<Any>) = ins_1.getMapEntry(map_String)

    var token = ""
    var t1:Time = Time.now()
    var t2 = Time(2023, Month.August, 5)
    // var customPtn = "yyyy/MM/dd HH:mm:ss ZZZZ"
    var customPtn = "yyyy/MM/dd HH:mm:ss ZZZZ"
    var t3 = Time.parse("2021-08-05T21:08:04+08:00")
    var t4 = Time.parse("2023/08/05 21:08:04 +08:00", customPtn)

    @TestCase
    func testWithExpiresAt_001():Unit{
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withKeyId(entry[0][1])//中文字符
      jwtBuilder.withAudience(ins_1.convertArrAnyToArrString(arr_Str1))
      // public func withExpiresAt(expiresAt: Time): Builder
      jwtBuilder.withExpiresAt(t2) // 2023-08-05T00:00:00+08:00
      jwtStr = jwtBuilder.sign(Algorithm.none()) 
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      // public func getExpiresAt(): Time
      strActual = jwtDecoder.getExpiresAt().toString()
      // println("strActual : ${strActual}")
      @Assert(strActual, t2.toString() )
      @Assert(returnTag, 0) 

    }

    @TestCase
    func testWithExpiresAt_002():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withHeader(map_Bool)
      try{
          jwtBuilder.withAudience(Array<String>())//空arr实例
      }catch(e1:Exception){
        returnTag = 1
      }
      jwtBuilder.withExpiresAt(t4) 
      jwtStr = jwtBuilder.sign(Algorithm.HMAC256("admin")) 
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 2
      }
      strActual = jwtDecoder.getExpiresAt().toString()
      @Assert(strActual, t4.toString() )
      @Assert(returnTag, 0) 
    }

}