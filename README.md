<div align="center">
<h1>jwt</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.36.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-89.6%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

一个基于RFC 7519 的 JSON Web Token 和 JSON Web Signature的仓颉库。

### 特性

- 🚀 支持 HMAC 算法签名及验证
- 🚀 支持 ECDSA 算法签名及验证
- 🚀 支持 RSA 算法签名及验证
- 🚀 支持 Payload 字段业务校验

### 路线

<p align="center">
<img src="./doc/assets/milestone.png" width="100%" >
</p>

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 源码目录

```shell
.
├── README.md
├── doc
│   ├── api.md
│   ├── assets
│   │   ├── framework.png
│   │   ├── logo.png
│   │   ├── milestone.png
│   │   ├── readme-icon-compile.png
│   │   ├── readme-icon-contribute.png
│   │   ├── readme-icon-framework.png
│   │   └── readme-icon-introduction.png
│   ├── design.md
│   ├── framework-roadmap-logo.pptx
│   ├── proposal.md
│   └── xxx_lib.md
├── src
│   └── jwt
│       ├── algorithms
│       │   ├── algorithm.cj
│       │   ├── ecdsa_algorithm.cj
│       │   ├── hmac_algorithm.cj
│       │   ├── none_algorithm.cj
│       │   └── rsa_algorithm.cj
│       ├── common
│       │   ├── header_params.cj
│       │   └── registered_claims.cj
│       ├── exception
│       │   ├── TokenExpiredException.cj
│       │   ├── algorithm_mismatch_exception.cj
│       │   ├── incorrect_claim_exception.cj
│       │   ├── invalid_claim_exception.cj
│       │   ├── jwt_creation_exception.cj
│       │   ├── jwt_decode_exception.cj
│       │   ├── jwt_validation_exception.cj
│       │   ├── jwt_verification_exception.cj
│       │   ├── missing_claim_exception.cj
│       │   ├── signature_generation_exception.cj
│       │   └── signature_verification_exception.cj
│       ├── impl
│       │   ├── json
│       │   │   ├── deserializer.cj
│       │   │   ├── json_extend.cj
│       │   │   ├── json_node_claim.cj
│       │   │   └── serializer.cj
│       │   ├── base_header.cj
│       │   ├── base_payload.cj
│       │   ├── claims_holder.cj
│       │   ├── claims_serializer.cj
│       │   ├── expected_check_holder_impl.cj
│       │   ├── header_claims_holder.cj
│       │   ├── header_deserializer.cj
│       │   ├── header_serializer.cj
│       │   ├── jwt_parser.cj
│       │   ├── payload_claims_holder.cj
│       │   ├── payload_deserializer.cj
│       │   └── payload_serializer.cj
│       ├── interfaces
│       │   ├── claim.cj
│       │   ├── decoded_jwt.cj
│       │   ├── ecdsa_key_provider.cj
│       │   ├── expected_check_holder.cj
│       │   ├── header.cj
│       │   ├── jwt_parts_parser.cj
│       │   ├── jwt_verifier.cj
│       │   ├── key_provider.cj
│       │   ├── node_type.cj
│       │   ├── payload.cj
│       │   ├── rsa_key_provider.cj
│       │   └── verification.cj
│       ├── utils
│       │   └── base64_util.cj
│       ├── base_verification.cj
│       ├── jwt.cj
│       ├── jwt_creator.cj
│       ├── jwt_decoder.cj
│       ├── jwt_verifier.cj
│       └── token_utils.cj
└── test   
    ├── HLT
    ├── LLT
    └── UT
```

- `doc`是库的设计文档、提案、库的使用文档
- `src`是库源码目录
- `test`是存放测试用例，包括HLT用例、LLT 用例和UT用例

### 接口说明

主要是核心类和成员函数说明,详情见 [API](./doc/api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

```shell
# 使用cpm编译
# jwt依赖cryptocj, 需要在module.json中requires项配置cryptocj目录(需预编译cryptocj)
# 然后在jwt目录build
cpm build
```
```shell
# 使用ci脚本编译
# 引入 testJekins 包,保持原目录结构
# 地址：https://gitee.com/HW-PLLab/testJekins 将 src 下 ci_test 放入 ini 根目录下
python3 ci_test/main.py build
python3 ci_test/main.py test
```
### 功能示例
<p align="center">
<img src="./doc/assets/jwtProcess.png" width="100%" >
</p>

#### jwt创建功能示例
``` cangjie
from std import collection.*
from std import time.*
from encoding import json.*
from jwt import jwt.algorithms.*
from jwt import jwt.*

main(){
    let jwtStr = JWT.create()
        .withHeader(HashMap<String, Any>([("k1","v1")]))
        .withKeyId("keyId")
        .withIssuer("issuer")
        .withSubject("subject")
        .withAudience(["aud1", "aud2"])
        .withExpiresAt(Time(3673835050,0))
        .withNotBefore(Time(1673835050,0))
        .withIssuedAt(Time(1673835000,0))
        .withJWTId("jwtId")
        .withClaim("bool", true)
        .withClaim("ddd", "dfdddff")
        .withClaim("int64", 64)
        .withClaim("float64", 3.14)
        .withClaim("String", "abaaba")
        .withClaim("time", Time(1673850000,0))
        .withClaim("map", HashMap<String, Any>([("mk2","mv2")]))
        .withClaim("list", ArrayList<Any>([56.51,41.96]))
        .withNullClaim("null")
        .withArrayClaim("arraystring", ["astr1","astr2"])
        .withArrayClaim("arrayint", [684,64])
        .withPayload(HashMap<String, Any>([("pk1","pv1"),("pk2","pv2")]))
        .sign(Algorithm.HMAC256("admin"))
    println(jwtStr)
    0
}
```

#### jwt解析功能示例
```
from jwt import jwt.*

let token = 
    "CnsKICAiazEiOiAidjEiLAogICJraWQiOiAiYWxnb3JpdGhtLmdldFNpZ25pbmdLZXlJZCgpIiwKICAiYWxnIjogIm5vbmUiLAogICJ0eXAiOiAiSldUIiwKICAiY3R5IjogIkpXVCIKfQo.ewogICJpc3MiOiAiaXNzdWVyIiwKICAic3ViIjogInN1YmplY3QiLAogICJhdWQiOiBbCiAgICAiYXVkMSIsCiAgICAiYXVkMiIKICBdLAogICJleHAiOiAxNjczODM1MDkwLAogICJuYmYiOiAxNjczODM1MDUwLAogICJpYXQiOiAxNjczODM1MDAwLAogICJqdGkiOiAiand0SWQiLAogICJib29sIjogdHJ1ZSwKICAiaW50NjQiOiA2NCwKICAiZmxvYXQ2NCI6IDMuMTQwMDAwLAogICJTdHJpbmciOiAiYWJhYWJhIiwKICAidGltZSI6IDE2NzM4NTAwMDAsCiAgIm1hcCI6IHsKICAgICJtazIiOiAibXYyIgogIH0sCiAgImxpc3QiOiBbCiAgICA1Ni41MTAwMDAsCiAgICA0MS45NjAwMDAKICBdLAogICJudWxsIjogbnVsbCwKICAiYXJyYXlzdHJpbmciOiBbCiAgICAiYXN0cjEiLAogICAgImFzdHIyIgogIF0sCiAgImFycmF5aW50IjogWwogICAgNjg0LAogICAgNjQKICBdLAogICJwazEiOiAicHYxIiwKICAicGsyIjogInB2MiIKfQ==."

main() {
    let decoder = JWT.decode(token)
    println(decoder.getAlgorithm())             // none
    println(decoder.getType())                  // JWT
    println(decoder.getContentType())           // JWT
    println(decoder.getKeyId())                 // algorithm.getSigningKeyId()
    println(decoder.getHeaderClaim("k1").asString()) // v1
    println(decoder.getIssuer())                // issuer
    println(decoder.getSubject())               // subject
    println(decoder.getAudience().size)         // 2
    println(decoder.getExpiresAt())             // Time(1673835090,0))
    println(decoder.getNotBefore())             // Time(1673835050,0))
    println(decoder.getIssuedAt())              // Time(1673835000,0))
    println(decoder.getId())                    // jwtId
    println(decoder.getClaim("bool").asBool())  // true
    println(decoder.getClaims().size)           // 19
    0
}
```

#### jwt校验功能示例
```
from jwt import jwt.algorithms.*
from jwt import jwt.*

let token = "ewogICJrMSI6ICJ2MSIsCiAgImtpZCI6ICJrZXlJZCIsCiAgImFsZyI6ICJub25lIiwKICAidHlwIjogIkpXVCIKfQ.ewogICJpc3MiOiAiaXNzdWVyIiwKICAic3ViIjogInN1YmplY3QiLAogICJhdWQiOiBbCiAgICAiYXVkMSIsCiAgICAiYXVkMiIKICBdLAogICJleHAiOiAzNjczODM1MDUwLAogICJuYmYiOiAxNjczODM1MDUwLAogICJpYXQiOiAxNjczODM1MDAwLAogICJqdGkiOiAiand0SWQiLAogICJib29sIjogdHJ1ZSwKICAiZGRkIjogImRmZGRkZmYiLAogICJpbnQ2NCI6IDY0LAogICJmbG9hdDY0IjogMy4xNDAwMDAsCiAgIlN0cmluZyI6ICJhYmFhYmEiLAogICJ0aW1lIjogMTY3Mzg1MDAwMCwKICAibWFwIjogewogICAgIm1rMiI6ICJtdjIiCiAgfSwKICAibGlzdCI6IFsKICAgIDU2LjUxMDAwMCwKICAgIDQxLjk2MDAwMAogIF0sCiAgIm51bGwiOiBudWxsLAogICJhcnJheXN0cmluZyI6IFsKICAgICJhc3RyMSIsCiAgICAiYXN0cjIiCiAgXSwKICAiYXJyYXlpbnQiOiBbCiAgICA2ODQsCiAgICA2NAogIF0sCiAgInBrMSI6ICJwdjEiLAogICJwazIiOiAicHYyIgp9."
main() {
    try {
        let require = JWT.require(Algorithm.none())
        require.withClaim("String","abaaba")
            .withArrayClaim("arraystring",["astr1","astr2"])
            .withArrayClaim("arrayint", [684,64])
            .withClaim("time", Time(1673850000,0))
            .withClaim("bool", true)
            .withClaim("int64", 64)
            .withClaim("float64", 3.14)
            .withIssuer("issuer") // 签发对象
            .withAudience(["aud1"]) // 接收全部对象   ["aud1", "aud3"] false
            .withAnyOfAudience(["aud1", "aud3"]) // 接收部分对象
            .withSubject("subject")
            .withJWTId("jwtId")
            .withClaimPresence("ddd")
            .acceptExpiresAt(111111)
            .acceptLeeway(111111) // 设置默认时间
        let verifier: JWTVerifier = require.build()
        verifier.verify(token)
        return 0
    } catch (e: TokenExpiredException) {
        println(e.message)
        return 2
    } catch (e: Exception) {
        return 3
    }
    0
}
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

[@shawnzhao19](https://gitee.com/shawnzhao19)
[@heimudan](https://gitee.com/heimudan)
[@yangtao242](https://gitee.com/yangtao242)


欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
