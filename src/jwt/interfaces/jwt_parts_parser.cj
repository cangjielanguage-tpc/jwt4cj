package jwt.interfaces

/**
 * The JWTPartsParser class defines which parts of the JWT should be converted
 * to its specific Object representation instance.
 */
public interface JWTPartsParser<T> {
    /**
     * Parses the given JSON into a Payload instance.
     *
     * @param json the content of the Payload in a JSON representation.
     * @return the Payload.
     * @throws JWTDecodeException if the json doesn't have a proper JSON format.
     */
    func parsePayload(jsons: String): Payload<T>

    /**
     * Parses the given JSON into a Header instance.
     *
     * @param json the content of the Header in a JSON representation.
     * @return the Header.
     * @throws JWTDecodeException if the json doesn't have a proper JSON format.
     */
    func parseHeader(jsons: String): Header<T>
}
