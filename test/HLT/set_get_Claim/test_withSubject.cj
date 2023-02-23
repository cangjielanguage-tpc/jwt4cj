// 3rd_party_lib:jwt/build/jwt
// 3rd_party_lib:jwt/ci_lib/cryptocj
//dependence:../utils_test/createsourcedata.cj

from jwt import jwt.algorithms.*
from jwt import jwt.utils.*
from jwt import jwt.interfaces.*
from jwt import jwt.impl.*
from jwt import jwt.*
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
  public func withSubject(subject: String): Builder
  public func sign(algorithm: Algorithm): String
  public func getToken(): String
  public func getSubject(): String
*/

@Test
public class JWTTest {
    var returnTag: Int64 = -1
    var jwtStr:String = ""
    var jwtProp:String = ""
    let ins_1:SourceData = SourceData()
    let map_String:HashMap<String, Any> = ins_1.generateSourceDataWithString()[2]
    let map_Bool:HashMap<String, Any> = ins_1.generateSourceDataWithBool()[2]
    let entry:(ArrayList<String>,ArrayList<Any>) = ins_1.getMapEntry(map_String)

    var token = ""
    @TestCase
    func testWithSubject_001():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withIssuer(entry[0][1])//中文字符
      // public func withSubject(subject: String): Builder
      jwtBuilder.withSubject("\"Hello Cangjie \nLang\"") //转义字符 
      jwtStr = jwtBuilder.sign(Algorithm.none()) //不经过加密,jwtStr以"."结尾
      // println("jwtStr : ${jwtStr}")
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      // public func getSubject(): String
      jwtProp = jwtDecoder.getSubject()
      @Assert(jwtProp, "\"Hello Cangjie \nLang\"") 
      @Assert(returnTag, 0) 

    }

    @TestCase
    func testWithSubject_002():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withHeader(map_Bool)
      //拼接Str
      .withIssuer(entry[0][5]) 
      jwtBuilder.withSubject("") //空字符   
      jwtStr = jwtBuilder.sign(Algorithm.HMAC256("admin")) 
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      jwtProp = jwtDecoder.getSubject()
      @Assert(jwtProp, "") 
      @Assert(returnTag, 0) 
    }

    @TestCase
    func testWithSubject_003():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withHeader(map_Bool)
      .withSubject("$%^&^(*&)(#@#@|||<>)") //特殊字符   
      jwtStr = jwtBuilder.sign(Algorithm.HMAC256("admin")) 
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      jwtProp = jwtDecoder.getSubject()
      @Assert(jwtProp, "$%^&^(*&)(#@#@|||<>)") 
      @Assert(returnTag, 0) 
    }


}