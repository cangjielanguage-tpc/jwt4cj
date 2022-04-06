package jwt.interfaces

from encoding import json.*

public interface Claim {

    func getValue(): JsonValue


    func asBool(): Bool


    func asString(): String


    func asInt64(): Int64


    func asFloat64(): Float64

    //func asObject<T>(): T

}