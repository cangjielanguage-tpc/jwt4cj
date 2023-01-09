from std import collection.*
from std import time.*
import jwt.interfaces.*

public class Impl <: Claim {
    public func isNull(): Bool {
        true
    }

    public func isMissing(): Bool {
        true
    }

    public func asBool(): Option<Bool> {
        return Option.None
    }

    public func asInt(): Option<Int64> {
        return Option.None
    }

    public func asFloat(): Option<Float64> {
        return Option.None
    }

    public func asString(): Option<String> {
        return Option.None
    }

    public func asTime(): Option<Time> {
        return Option.None
    }

    public func asArray(): Option<Array<Any>> {
        return Option.None
    }

    public func asList(clazz: Any): Option<ArrayList<Any>> {
        return Option.None
    }

    public func asMap(): Option<Map<String, Any>> {
        return Option.None
    }

    public func asT(clazz: Any): Option<Any> {
        return Option.None
    }
}
main() {
    println("start")
    var impl = Impl()
    println(impl.isNull())
    impl.asT("asd")
    -1
    // println(impl.asT("asd") == Option.None)
}
