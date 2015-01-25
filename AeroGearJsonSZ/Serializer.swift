/**
Main class that provides convenient methods for serializing/deserializing from/to JSON structures.
*/
public class Serializer {
    var values: [String:  AnyObject] = [:]
    var key: String?
    var value: AnyObject?
    
    public init() {}
    
    public subscript(key: String) -> Serializer {
        get {
            self.key = key
            self.value = self.values[key]
            
            return self
        }
    }
    
    /**
    Convert from JSON to Object.
    
    :param: json      the JSON structure
    :param: type        the type of the object to be constructed
    
    :returns: the object initialized from the JSON structure
    */
    public func fromJson<N: FromJsonSerializable>(json: AnyObject,  to type: N.Type) -> N {
        if let string = json as? String {
            if let data =  json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) {
                self.values = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String: AnyObject]
            }
        } else if let dictionary = json as? [String: AnyObject] {
            self.values = dictionary
        }
        
        var object = N()
        N.fromJson(self, to: object)
        return object
    }
    
    /**
    Convert from JSON to Object.
    
    :param: json      the top-level JSON array that wraps the objects.
    :param: type        the type of the object to be constructed.
    
    :returns: the array of objects initialized from the JSON structure.
    */
    public func fromJsonArray<N: FromJsonSerializable>(json: AnyObject,  to type: N.Type) -> [N]? {
        if let string = json as? String {
            if let data =  json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) {
                let parsed: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                if let array = parsed as? [[String: AnyObject]] {
                    var objects: [N] = []
                    
                    for element in array {
                        self.values = element
                        var object = N()
                        N.fromJson(self, to: object)
                        objects.append(object)
                    }
                    
                    return objects
                }
            }
        }
        
        return nil
    }
    
    /**
    Serialize type to JSON.
    
    :param: object     a JSONSerializable object from which JSON would be constructed.
    :param: type        the type of the object to be constructed.
    
    :returns: the array of objects initialized from the JSON structure.
    */
    public func toJson<N: ToJsonSerializable>(object: N) -> [String:  AnyObject] {
        self.values = [String : AnyObject]()
        N.toJson(self, from: object)
        return self.values
    }
}