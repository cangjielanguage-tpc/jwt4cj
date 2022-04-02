package jwt.interfaces

public interface DecodeJWT <: Header & Payload & ToString {
    func getHeader(): String

    func getPayload(): String

    func getSignature(): String
}