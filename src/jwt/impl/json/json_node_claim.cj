package jwt.impl.json

from encoding import json.*
from std import collection.*
from std import time.*
import jwt.exception.JWTDecodeException
import jwt.exception.MissingClaimException
import jwt.interfaces.Claim
import jwt.interfaces.NodeType

public let NULL_NODE: JsonValue = JsonNull()
public let MISSING_CLAIM = JsonNodeClaim()

func createClaim(data: JsonValue): Claim {
    JsonNodeClaim(data)
}

/*
 * 使用std.json实现的claim
 */
public class JsonNodeClaim <: Claim {
    private let data: JsonValue
    private var missing = false

    protected init() {
        this.data = NULL_NODE
        this.missing = true
    }

    public init(data: JsonValue) {
        this.data = data
    }

    public func isNull(): Bool {
        !isMissing() && data.kind() == JsonKind.JsNull
    }

    public func isMissing(): Bool {
        missing
    }

    public func asBool(): Bool {
        data.asBool().getValue()
    }

    public func asInt(): Int64 {
        data.asInt().getValue()
    }

    public func asFloat(): Float64 {
        data.asFloat().getValue()
    }

    public func asString(): String {
        data.asString().getValue()
    }

    public func asTime(): Time {
        Time(data.asInt().getValue(), 0)
    }

    public func asArray(): Array<JsonValue> {
        asList().toArray()
    }

    public func asList(): ArrayList<JsonValue> {
        data.asArray().getItems()
    }

    public func asMap(): Map<String, JsonValue> {
        data.asObject().getFields()
    }

    public func getValue(): JsonValue {
        return data
    }

    public func toString(): String {
        if (missing) {
            throw MissingClaimException()
        } else {
            data.toStr()
        }
    }
}
