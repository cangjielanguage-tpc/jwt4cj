package jwt.impl.json

from encoding import json.*
from std import collection.ArrayList
from std import collection.Map
from std import time.Time
import jwt.interfaces.Claim

/*
 * 使用std.json实现的claim
 */
public class JsonNodeClaim <: Claim {
    private let data: JsonValue

    public init(data: JsonValue) {
        this.data = data
    }

    public func isNull(): Bool {
        data.kind() == JsonKind.JsNull
    }

    public func isMissing(): Bool {
        data.kind() == JsonKind.JsNull
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
}

extend JsonValue {
    operator func ==(other: JsonValue): Bool {
        this.toString() == other.toString()
    }
}
extend JsonKind {
    private func toFlag(): Int64 {
        match (this) {
            case JsNull => 0
            case JsBool => 1
            case JsInt => 2
            case JsFloat => 3
            case JsString => 4
            case JsArray => 5
            case JsObject => 6
        }
    }
    operator func ==(other: JsonKind): Bool {
        this.toFlag() == other.toFlag()
    }
}
