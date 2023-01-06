package jwt.interfaces

public interface Header <: ToString {

    func getType(): String
    
    func getAlgorithm(): String

    func getContentType(): String

}
