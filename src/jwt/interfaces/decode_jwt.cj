package jwt.interfaces

public interface DecodeJWT <: Header & Payload & ToString {

    func getHeader(): Header

    func getEncodedHeader(): String

    func getPayload(): Payload

    func getEncodedPayload(): String

    func getSignature(): String

    func getToken(): String
}