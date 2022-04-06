package jwt.algorithm

public class HmacAlgorithm <: Algorithm {
    private var secret: String

    init(name: String, description: String, secret: String) {
        super(name, description)
        this.secret = secret
    }
}