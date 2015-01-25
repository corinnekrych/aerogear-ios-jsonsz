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
A class must implement this protocol to signal that is JSON serializable.
*/
public protocol FromJsonSerializable {
    
    /**
    A default constructor.
    */
    init()
    
    /**
    Called by the library to construct an object.
    
    Note:  The user doesn't need to invoke it directly, but would be called automatically by the
    library during construction of the object
    
    :param: source      the JsonSZ object that performs the serialization
    :param: Self           the object that is constructed.
    */
    class func fromJson(json: Serializer, to: Self)
}