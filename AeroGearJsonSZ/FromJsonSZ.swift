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

/**
Serialize/Deserialize to cover primitive types.

:param: left      inout serialized object of type T.
:param: right     JsonSZ object to hold json structure.
*/
public func <=<T>(inout left: T?, right: Serializer) {
    fromPrimitiveType(&left, right.value)
}


/**
Serialize/Deserialize to cover object types.

:param: left      inout serialized object of type T.
:param: right     JsonSZ object to hold json structure.
*/
public func <=<T: FromJsonSerializable>(inout left: T?, right: Serializer) {
    fromObjectType(&left, right.value)
}

/**
Serialize/Deserialize to cover array types.

:param: left      inout serialized object of type [T].
:param: right     JsonSZ object to hold json structure.
*/
public func <=<T: FromJsonSerializable>(inout left: [T]?, right: Serializer) {
    fromArrayType(&left, right.value)
}

/**
Serialize/Deserialize to cover array primitive types.

:param: left      inout serialized object of type [AnyObject]?.
:param: right     JsonSZ object to hold json structure.
*/
public func <=(inout left: [AnyObject]?, right: Serializer) {
    fromPrimitiveType(&left, right.value)
}

/**
Serialize/Deserialize to cover array dictionary types.

:param: left      inout serialized object of type [String:  T]?.
:param: right     JsonSZ object to hold json structure.
*/
public func <=<T: FromJsonSerializable>(inout left: [String:  T]?, right: Serializer) {
    fromDictionaryType(&left, right.value)
}

/**
Serialize/Deserialize to cover array dictionary primitives.

:param: left      inout serialized object of type [String:  T]?.
:param: right     JsonSZ object to hold json structure.
*/
public func <=(inout left: [String:  AnyObject]?, right: Serializer) {
    fromPrimitiveType(&left, right.value)
}

// Mark - Internal utilities functions

func fromPrimitiveType<FieldType>(inout field: FieldType?, value: AnyObject?) {
    if let value: AnyObject = value {
        switch FieldType.self {
        case is String.Type:
            field = value as? FieldType
        case is Bool.Type:
            field = value as? FieldType
        case is Int.Type:
            field = value as? FieldType
        case is Double.Type:
            field = value as? FieldType
        case is Float.Type:
            field = value as? FieldType
        case is Array<AnyObject>.Type:
            field = value as? FieldType
        case is Dictionary<String, AnyObject>.Type:
            field = value as? FieldType
        case is NSDate.Type:
            field = value as? FieldType
        default:
            field = nil
            return
        }
    }
}

func fromObjectType<N: FromJsonSerializable>(inout field: N?, value: AnyObject?) {
    if let value = value as? [String:  AnyObject] {
        field = Serializer().fromJson(value, to: N.self)
    }
}

func fromArrayType<N: FromJsonSerializable>(inout field: [N]?, value: AnyObject?) {
    let serializer = Serializer()
    
    var objects = [N]()
    
    if let array = value as [AnyObject]? {
        for object in array {
            var object = serializer.fromJson(object as [String: AnyObject],  to: N.self)
            objects.append(object)
        }
    }
    
    field = objects.count > 0 ? objects: nil
}

func fromDictionaryType<N: FromJsonSerializable>(inout field: [String: N]?, value: AnyObject?) {
    let serializer = Serializer()
    
    if let dictionary = value as? [String: AnyObject] {
        var objects = [String: N]()
        
        for (key, object) in dictionary {
            var object = serializer.fromJson(object as [String:  AnyObject], to: N.self)
            objects[key] = object
        }
        
        field = objects.count > 0 ? objects: nil
    }
}