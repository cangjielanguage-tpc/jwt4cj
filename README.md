<div align="center">
<h1>jwt</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.36.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-0%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

一个基于RFC 7519 的 JSON Web Token 和 JSON Web Signature的仓颉库。

### 特性

- 🚀 支持 HMAC 算法及验证
- 🚀 支持 ECDSA 算法及验证
- 🚀 支持 RSA 算法及验证

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
│   ├── assets
│   ├── api.md
│   ├── design.md
│   ├── framework-roadmap-logo.pptx
│   ├── proposal.md
│   └── xxx_lib.md
├── src
│   └── jwt
│       ├── algorithms
│       ├── exceptions
│       ├── impl
│       ├── interfaces
│   └── headerParams.cj
│   └── jwt.cj
│   └── jwtCreator.cj
│   └── jwtDecoder.cj
│   └── jwtVerifier.cj
│   └── registeredClaims.cj
│   └── tokenUtils.cj
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

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 编译执行

### 编译

```shell
cd test/LLT
cjc ./*.cj
```
### 安装

```shell
# install cjc;
source cangjie/cangjie/envsetup.sh;
cjc -v;
```

### 运行

```cangjie
 cjc testcase0001.cj
 ./main
 echo $?
```

### 使用说明

#### XXX功能示例

执行结果如下：

```shell
***
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

[@shawnzhao19](https://gitee.com/shawnzhao19)
