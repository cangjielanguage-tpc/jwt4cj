package jwt.algorithm

public abstract class Algorithm {
    private var name: String;
    private var description: String;

    init(name: String, description: String) {
        this.name = name
        this.description = description
    }


    public static func HMAC256(secret: String): Algorithm {
        return HmacAlgorithm("HS256", "HmacSHA256", secret);
    }
}