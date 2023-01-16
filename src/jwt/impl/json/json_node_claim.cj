package jwt.impl.json

from encoding import json.*
from std import collection.ArrayList
from std import collection.Map
from std import time.Time
import jwt.exception.JWTDecodeException
import jwt.interfaces.Claim
import jwt.interfaces.NodeType

let JSON_NULL = JsonNull()

/*
 * 使用std.json实现的claim
 */
public class JsonNodeClaim <: Claim {
    private let data: JsonValue
    private var missing = false

    protected init() {
        this.data = JSON_NULL
        this.missing = true
    }

    public init(data: NodeType) {
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

    public func asArray(): Array<NodeType> {
        asList().toArray()
    }

    public func asList(): ArrayList<NodeType> {
        data.asArray().getItems()
    }

    public func asMap(): Map<String, NodeType> {
        data.asObject().getFields()
    }

    public func getValue(): NodeType {
        return data
    }

    public func toString(): String {
        if (missing) {
            ""
        } else {
            data.toStr()
        }
    }
}

func createClaim(data: JsonValue): Claim {
    JsonNodeClaim(data)
}

public let MISSING_CLAIM = JsonNodeClaim()
