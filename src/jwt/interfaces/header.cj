package jwt.interfaces

from serialization import serialization.*

public interface Header <: ToString {
    /**
     *
     * 
     */
    func getType(): String
    
    func getAlgorithm(): String

    func getContentType(): String

}