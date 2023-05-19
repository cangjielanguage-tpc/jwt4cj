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
  public func withIssuer(issuer: String): Builder
  public func sign(algorithm: Algorithm): String
  public func getToken(): String
  public func getIssuer(): String
*/

@Test
public class JWTTest {
    var returnTag: Int64 = -1
    var jwtStr:String = ""
    var issuer:String = ""
    let ins_1:SourceData = SourceData()
    let map_String:HashMap<String, Any> = ins_1.generateSourceDataWithString()[2]
    let map_Bool:HashMap<String, Any> = ins_1.generateSourceDataWithBool()[2]
    let entry:(ArrayList<String>,ArrayList<Any>) = ins_1.getMapEntry(map_String)

    var token = ""
    @TestCase
    func testWithIssuer_001():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      // public func withIssuer(issuer: String): Builder
      jwtBuilder.withIssuer(entry[0][1])//中文字符
      jwtStr = jwtBuilder.sign(Algorithm.none()) //不经过加密,jwtStr以"."结尾
      // println("jwtStr : ${jwtStr}")
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      // public func getIssuer(): String
      issuer = jwtDecoder.getIssuer()
      @Assert(issuer, entry[0][1]) 
      @Assert(returnTag, 0) 

    }

    @TestCase
    func testWithIssuer_002():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withHeader(map_Bool)
      //拼接Str
      .withIssuer(entry[0][4])   
      .withIssuer(entry[0][5])  //连续设置
      jwtStr = jwtBuilder.sign(Algorithm.HMAC256("admin")) 
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      issuer = jwtDecoder.getIssuer()
      // println("issuer : ${issuer}")
      @Assert(issuer, entry[0][5]) 
      @Assert(returnTag, 0) 
    }

    @TestCase
    func testWithIssuer_003():Unit{ 
      returnTag = 0
      let jwtBuilder :Builder = JWT.create()
      jwtBuilder.withHeader(map_Bool)
      .withIssuer("")  //空str
      jwtStr = jwtBuilder.sign(Algorithm.HMAC256("admin")) 
      let jwtDecoder = JWTDecoder(jwtStr)
      token = jwtDecoder.getToken() 
      if(token != jwtStr){
        returnTag = 1
      }
      issuer = jwtDecoder.getIssuer()
      // println("issuer : ${issuer}")
      @Assert(issuer, "") 
      @Assert(returnTag, 0) 
    }


}