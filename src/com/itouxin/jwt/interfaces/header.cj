package com.itouxin.jwt.interfaces

public interface Header {
    /**
     *
     * 
     */
    func getType(): String
    func getAlgorithm(): String

}