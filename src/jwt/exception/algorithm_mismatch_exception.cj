package jwt.exception

public class AlgorithmMismatchException <: RuntimeException {
    public init(message: String) {
        super(message);
    }
}