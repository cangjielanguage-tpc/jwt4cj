package jwt.impl

public class BaseClaim <: Claim {

    private var value: JsonValue

    init(value: JsonValue) {
        this.value = value
    }


    public func getValue(): JsonValue {
        return value
    }


    public func asBool(): Bool {
        let op: Option<JsonBool> = value as JsonBool
        return op.getOrThrow().getValue()
    }


    public func asString(): String {
        return (value as JsonString).getOrThrow().getValue()
    }


    public func asInt64(): Int64 {
        return (value as JsonInt).getOrThrow().getValue()
    }


    public func asFloat64(): Float64 {
        return (value as JsonFloat).getOrThrow().getValue()
    }


    // public func serialize(): DataModel {
    //     println(value.toString())
    //     return DataModel.fromJson(value)
    // }


    // public static func deserialize(dm: DataModel): Claim {
    //     println(dm.toJson().toString())
    //     var dms = match (dm) {
    //         case data: DataModelStruct => data
    //         case _ => throw Exception("this data is not DataModelStruct") 
    //     }
    //     println(dms.toJson().toString())
    //     return BaseClaim(dms.toJson())
    // }
}