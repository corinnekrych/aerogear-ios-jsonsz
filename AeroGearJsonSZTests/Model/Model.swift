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

    var street: String = ""
    var poBox: Int?
    var city: String!
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
    var firstname: String = "Default"
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