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

class Address: FromJsonSerializable, ToJsonSerializable {
    var street: String?
    var poBox: Int?
    var city: String?
    var country: String?
    
    required init() {}
    
    class func fromJson(json: Serializer, to object: Address) {
        object.street <= json["street"]
        object.poBox <= json["poBox"]
        object.city <= json["city"]
        object.country <= json["country"]
    }

    class func toJson(json: Serializer, from object: Address) {
        object.street => json["street"]
        object.poBox => json["poBox"]
        object.city => json["city"]
        object.country => json["country"]
    }
}

class Contributor: FromJsonSerializable, ToJsonSerializable {
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
    
    class func fromJson(json: Serializer, to object: Contributor) {
        object.id <= json["id"]
        object.firstname <= json["firstname"]
        object.lastname <= json["lastname"]
        object.title <= json["title"]
        object.age <= json["age"]
        object.committer <= json["committer"]
        object.weight <= json["weight"]
        object.githubReposList <= json["githubReposList"]
        object.dictionary <= json["dictionary"]
        object.address <= json["address"]
    }
    
    class func toJson(json: Serializer, from object: Contributor) {
        object.id => json["id"]
        object.firstname => json["firstname"]
        object.lastname => json["lastname"]
        object.title => json["title"]
        object.age => json["age"]
        object.committer => json["committer"]
        object.weight => json["weight"]
        object.githubReposList => json["githubReposList"]
        object.dictionary => json["dictionary"]
        object.address => json["address"]
    }
}

class Team: FromJsonSerializable, ToJsonSerializable {
    var name: String?
    var contributors: [Contributor]?
    
    required init() {}
    
    class func fromJson(json: Serializer, to object: Team) {
        object.name <= json["name"]
        object.contributors <= json["contributors"]
    }
    
    class func toJson(json: Serializer, from object: Team) {
        object.name => json["name"]
        object.contributors => json["contributors"]
    }
}