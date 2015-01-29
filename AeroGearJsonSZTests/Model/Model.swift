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

import AeroGearJsonSZ

class Address: JSONSerializable {
    
    var street: String?
    var poBox: Int?
    var city: String?
    var country: String?
    
    required init() {}
    
    class func map(source: JsonSZ, object: Address) {
        object.street <= source["street"]
        object.poBox <= source["poBox"]
        object.city <= source["city"]
        object.country <= source["country"]
    }
}

class Contributor: JSONSerializable {
    
    var id: Int?
    var firstname: String?
    var lastname: String?
    var title: String?
    var age: Double?
    var committer: Bool?
    var weight: Float?
    var githubReposList:[AnyObject]?
    var dictionary:[String: AnyObject]?
    var address: Address?
    
    required init() {}
    
    class func map(source: JsonSZ, object: Contributor) {
        object.id <= source["id"]
        object.firstname <= source["firstname"]
        object.lastname <= source["lastname"]
        object.title <= source["title"]
        object.age <= source["age"]
        object.committer <= source["committer"]
        object.weight <= source["weight"]
        object.githubReposList <= source["githubReposList"]
        object.dictionary <= source["dictionary"]
        object.address <= source["address"]
    }
}

class Team: JSONSerializable {
    var name: String?
    var contributors: [Contributor]?
    
    required init() {}
    
    class func map(source: JsonSZ, object: Team) {
        object.name <= source["name"]
        object.contributors <= source["contributors"]
    }
}

class TestCollectionOfPrimitives : JSONSerializable {
    var dictStringString: [String: String]?
    var dictStringInt: [String: Int]?
    var dictStringBool: [String: Bool]?
    var dictStringDouble: [String: Double]?
    var dictStringFloat: [String: Float]?
    var arrayString: [String]?
    var arrayInt: [Int]?
    var arrayBool: [Bool]?
    var arrayDouble: [Double]?
    var arrayFloat: [Float]?
    required init() {}
    
    class func map(source: JsonSZ, object: TestCollectionOfPrimitives) {
        object.dictStringString <= source["dictStringString"]
        object.dictStringBool <= source["dictStringBool"]
        object.dictStringInt <= source["dictStringInt"]
        object.dictStringDouble <= source["dictStringDouble"]
        object.dictStringFloat <= source["dictStringFloat"]
        object.arrayString <= source["arrayString"]
        object.arrayInt <= source["arrayInt"]
        object.arrayBool <= source["arrayBool"]
        object.arrayDouble <= source["arrayDouble"]
        object.arrayFloat <= source["arrayFloat"]
    }
}

class TestCollectionOfPrimitivesNonOptional : JSONSerializable {
    var dictStringString: [String: String] = [:]
    var dictStringInt: [String: Int] = [:]
    var dictStringBool: [String: Bool] = [:]
    var dictStringDouble: [String: Double] = [:]
    var dictStringFloat: [String: Float] = [:]
    var arrayString: [String] = []
    var arrayInt: [Int] = []
    var arrayBool: [Bool] = []
    var arrayDouble: [Double] = []
    var arrayFloat: [Float] = []
    
    required init() {}
    
    class func map(source: JsonSZ, object: TestCollectionOfPrimitivesNonOptional) {
        object.dictStringString <= source["dictStringString"]
        object.dictStringBool <= source["dictStringBool"]
        object.dictStringInt <= source["dictStringInt"]
        object.dictStringDouble <= source["dictStringDouble"]
        object.dictStringFloat <= source["dictStringFloat"]
        object.arrayString <= source["arrayString"]
        object.arrayInt <= source["arrayInt"]
        object.arrayBool <= source["arrayBool"]
        object.arrayDouble <= source["arrayDouble"]
        object.arrayFloat <= source["arrayFloat"]
    }
}
/**
A class to test non-optional object model
*/
class Developer: JSONSerializable {
    // put some defaults to satisfy swift object construction (not used)
    var id: Int = 0
    var firstname: String = ""
    var lastname: String = ""
    var title: String = ""
    var age: Double = 0
    var committer: Bool = false
    var weight: Float = 0
    var githubReposList:[AnyObject] = []
    var dictionary:[String: AnyObject] = [:]
    
    var address: Address = Address()
    
    required init() {}
    
    class func map(source: JsonSZ, object: Developer) {
        object.id <= source["id"]
        object.firstname <= source["firstname"]
        object.lastname <= source["lastname"]
        object.title <= source["title"]
        object.age <= source["age"]
        object.committer <= source["committer"]
        object.weight <= source["weight"]
        object.githubReposList <= source["githubReposList"]
        object.dictionary <= source["dictionary"]
        object.address <= source["address"]
    }
}

