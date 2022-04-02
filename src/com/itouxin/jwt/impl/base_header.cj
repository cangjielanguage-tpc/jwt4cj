package com.itouxin.jwt.impl

import com.itouxin.jwt.interfaces.*

public class BaseHeader <: Header {

    private var algorithm: String
    private var `type`: String

    public init(algorithm: String) {
        this("jwt", algorithm)
    }

    public init(`type`: String, algorithm: String) {
        this.`type` = `type`
        this.algorithm = algorithm
    }

    public func getAlgorithm(): String {
        return this.algorithm
    }


    public func getType(): String {
        return this.`type`
    }

}