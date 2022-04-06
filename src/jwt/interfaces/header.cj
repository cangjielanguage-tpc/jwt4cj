package jwt.interfaces

from std import serialization.*

public interface Header <: Serializable<Header> {
    /**
     *
     * 
     */
    func getType(): String
    func getAlgorithm(): String

}