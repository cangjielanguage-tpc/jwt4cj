package jwt.impl

from encoding import json.JsonException
import jwt.exception.JWTDecodeException
import jwt.interfaces.JWTPartsParser

public class JWTParser <: JWTPartsParser {
    private let headerReader = HeaderDeserializer()
    private let payloadReader = PayloadDeserializer()

    init() {}

    public override func parseHeader(jsons: String): Header {
        try {
            headerReader.doDeserialize(jsons)
        } catch (e: JsonException) {
            throw JWTDecodeException("The string '${jsons}' doesn't have a valid JSON format.")
        }
    }

    public override func parsePayload(jsons: String): Payload {
        try {
            payloadReader.doDeserialize(jsons)
        } catch (e: JsonException) {
            throw JWTDecodeException("The string '${jsons}' doesn't have a valid JSON format.")
        }
    }
}
