### 三方库设计说明

#### 1 需求场景分析

一个基于RFC 7519 的 JSON Web Token 和 JSON Web Signature的仓颉库。

#### 2 三方库对外提供的特性

（1）支持 HMAC 算法及验证
（2）支持 ECDSA 算法及验证
（3）支持 RSA 算法及验证

#### 3 License分析

MIT License

|  Permissions   | Limitations  |
|  ----  | ----  |
| Commercial use |  |
| Modification  |   |
| Distribution  |   |
| Private use   |   |

#### 4 依赖分析 

依赖

Java 库：javax.crypto.Mac, javax.crypto.spec.SecretKeySpec, java.nio.charset.StandardCharsets, java.security.*, java.time.Instant, java.lang.reflect.Array, com.fasterxml.jackson.databind.*, com.fasterxml.jackson.annotation.JsonInclude, java.time.Clock, java.time.Duration, java.time.temporal.ChronoUnit, java.util.function.BiPredicate

#### 5 特性设计文档

##### 5.1 核心特性1 

###### 5.1.1 特性介绍

    基于 HMAC 算法实现 JWT

###### 5.1.2 实现方案
    

###### 5.1.3 接口设计

💡 hmac_algorithm.cj 提供 HMAC 算法

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init   | name: String, description: String, secret: String | --- | hmac_algorithm name: 传入 String 类型字符串, description: 传入 String 类型字符串, secret: 传入 String 类型字符串 |

#### 6 思维导图

<img alt="" src="./assets/readme-icon-framework.png" style="display: inline-block;" width=60%/>
