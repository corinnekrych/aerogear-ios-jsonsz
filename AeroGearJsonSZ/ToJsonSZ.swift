/*
* JBoss, Home of Professional Open Source.
* Copyright Red Hat, Inc., and individual contributors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation


infix operator => {}

/**
Serialize/Deserialize to cover primitive types.

:param: left      inout serialized object of type T.
:param: right     JsonSZ object to hold json structure.
*/
public func =><T>(inout left: T?, right: Serializer) {
    toPrimitiveType(left, right.key!, &right.values)
}

/**
Serialize/Deserialize to cover object types.

:param: left      inout serialized object of type T.
:param: right     JsonSZ object to hold json structure.
*/
public func =><T: ToJsonSerializable>(inout left: T?, right: Serializer) {
    toObjectType(left, right.key!, &right.values)
}

/**
Serialize/Deserialize to cover array types.

:param: left      inout serialized object of type [T].
:param: right     JsonSZ object to hold json structure.
*/
public func =><T: ToJsonSerializable>(inout left: [T]?, right: Serializer) {
    toArrayType(left, right.key!, &right.values)
}

/**
Serialize/Deserialize to cover array primitive types.

:param: left      inout serialized object of type [AnyObject]?.
:param: right     JsonSZ object to hold json structure.
*/
public func =>(inout left: [AnyObject]?, right: Serializer) {
    toArrayType(left, right.key!, &right.values)
}

/**
Serialize/Deserialize to cover array dictionary types.

:param: left      inout serialized object of type [String:  T]?.
:param: right     JsonSZ object to hold json structure.
*/
public func =><T: ToJsonSerializable>(inout left: [String:  T]?, right: Serializer) {
    toDictionaryType(left, right.key!, &right.values)
}

/**
Serialize/Deserialize to cover array dictionary primitives.

:param: left      inout serialized object of type [String:  T]?.
:param: right     JsonSZ object to hold json structure.
*/
public func =>(inout left: [String:  AnyObject]?, right: Serializer) {
    toDictionaryType(left, right.key!, &right.values)
}



// Mark - utilies funtions

func toPrimitiveType<N>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
    if let field: N = field {
        switch N.self {
        case is Bool.Type:
            dictionary[key] = field as Bool
        case is Int.Type:
            dictionary[key] = field as Int
        case is Double.Type:
            dictionary[key] = field as Double
        case is Float.Type:
            dictionary[key] = field as Float
        case is String.Type:
            dictionary[key] = field as String
        default:
            return
        }
    }
}

func toObjectType<N: ToJsonSerializable>(field: N?, key: String, inout dictionary: [String : AnyObject]) {
    if let field = field {
        dictionary[key] = NSDictionary(dictionary: Serializer().toJson(field))
    }
}

func toArrayType<N: ToJsonSerializable>(field: [N]?, key: String, inout dictionary: [String : AnyObject]) {
    if let field = field {
        var objects = NSMutableArray()
        
        for object in field {
            objects.addObject(Serializer().toJson(object))
        }
        
        if objects.count > 0 {
            dictionary[key] = objects
        }
    }
}

func toArrayType(field: [AnyObject]?, key: String, inout dictionary: [String : AnyObject]) {
    if let value = field {
        dictionary[key] = NSArray(array: value)
    }
}

func toDictionaryType<N: ToJsonSerializable>(field: [String: N]?, key: String, inout dictionary: [String : AnyObject]) {
    if let field = field {
        var objects = NSMutableDictionary()
        
        for (key, object) in field {
            objects.setObject(Serializer().toJson(object), forKey: key)
        }
        
        if objects.count > 0 {
            dictionary[key] = objects
        }
    }
}

func toDictionaryType(field: [String: AnyObject]?, key: String, inout dictionary: [String : AnyObject]) {
    if let value = field {
        dictionary[key] = NSDictionary(dictionary: value)
    }
}


