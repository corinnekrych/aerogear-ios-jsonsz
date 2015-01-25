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

import UIKit
import XCTest
import AeroGearJsonSZ

class AeroGearJsonSZTests: XCTestCase {
    
    var serializer: JsonSZ!
    
    override func setUp() {
        super.setUp()
        
        serializer = JsonSZ()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJSONToObjectModelWithioutNonOptionalFirstnameShouldReturnDefaut() {
        var contributorJSON = ["id": 100, "lastname": "Doe", "title": "Software Engineer", "age": 40, "committer": true, "weight": 60.2, "githubReposList":["foo", "bar"], "dictionary": ["foo": "bar"]]
        
        // serialize from json
        let contributor:Contributor = self.serializer.fromJSON(contributorJSON, to: Contributor.self)
        
        // assert construction has succeeded on primitive fields
        XCTAssertTrue(contributor.id == 100)
        XCTAssertTrue(contributor.firstname == "Default")
        XCTAssertTrue(contributor.lastname == "Doe")
        XCTAssertTrue(contributor.title == "Software Engineer")
        XCTAssertTrue(contributor.age == 40)
        XCTAssertTrue(contributor.committer == true)
        XCTAssertTrue(contributor.weight ==     60.2)
        XCTAssertTrue(contributor.githubReposList?.count == 2)
        XCTAssertTrue(contributor.dictionary?.count == 1)
        
    }
    
    func testJSONToObjectModelWithPrimitiveAttributes() {
        var contributorJSON = ["id": 100, "firstname": "John", "lastname": "Doe", "title": "Software Engineer", "age": 40, "committer": true, "weight": 60.2, "githubReposList":["foo", "bar"], "dictionary": ["foo": "bar"]]
        
        // serialize from json
        let contributor:Contributor = self.serializer.fromJSON(contributorJSON, to: Contributor.self)
        
        // assert construction has succeeded on primitive fields
        XCTAssertTrue(contributor.id == 100)
        XCTAssertTrue(contributor.firstname == "John")
        XCTAssertTrue(contributor.lastname == "Doe")
        XCTAssertTrue(contributor.title == "Software Engineer")
        XCTAssertTrue(contributor.age == 40)
        XCTAssertTrue(contributor.committer == true)
        XCTAssertTrue(contributor.weight ==     60.2)
        XCTAssertTrue(contributor.githubReposList?.count == 2)
        XCTAssertTrue(contributor.dictionary?.count == 1)
        
    }

    func testObjectModelToJSONWithPrimitiveAttributes() {
        // construct object
        let contributor = Contributor()
        contributor.id = 100
        contributor.firstname = "John"
        contributor.lastname = "Doe"
        contributor.title = "Software Engineer"
        contributor.age = 40
        contributor.committer = true
        contributor.weight = 60.2
        contributor.githubReposList = ["foo", "bar"]
        contributor.dictionary = ["foo": "bar"]
        
        // serialize to json
        let json = self.serializer.toJSON(contributor)
        
        // assert json dictionary has been populated
        XCTAssertTrue(json["id"] as Int == 100)
        XCTAssertTrue(json["firstname"] as String == "John")
        XCTAssertTrue(json["lastname"] as String == "Doe")
        XCTAssertTrue(json["title"] as String == "Software Engineer")
        XCTAssertTrue(json["age"] as Double == 40)
        XCTAssertTrue(json["committer"] as Bool == true)
        XCTAssertTrue(json["weight"] as Float == 60.2)
        XCTAssertTrue((json["githubReposList"] as [String]).count == 2)
        XCTAssertTrue((json["githubReposList"] as [String]).count == 2)
        XCTAssertTrue((json["dictionary"] as [String:String]).count == 1)
    }
    
     func testJSONToObjectModelWithPrimitiveAttributesAndMissingValues() {
        var contributorJSON = ["id": 100, "title":  "Software Engineer"]
        // serialize from json
        let contributor:Contributor = self.serializer.fromJSON(contributorJSON, to: Contributor.self)
        
        // assert construction has succeeded and missing values are nil
        XCTAssertTrue(contributor.id == 100)
        XCTAssertTrue(contributor.lastname == nil)
        XCTAssertTrue(contributor.title == "Software Engineer")
        XCTAssertTrue(contributor.age == nil)
        XCTAssertTrue(contributor.committer == nil)
        XCTAssertTrue(contributor.weight == nil)
    }
    
    func testObjectModelToJSONWithPrimitiveAttributesAndMissingValues() {
        // construct object
        let contributor = Contributor()
        contributor.id = 100
        contributor.title = "Software Engineer"
        
        // serialize to json
        let json = self.serializer.toJSON(contributor)
        
        // assert json dictionary has been populated
        XCTAssertTrue(json["id"] as? Int == 100)
        XCTAssertTrue(json["lastname"] == nil)
        XCTAssertTrue(json["title"] as? String == "Software Engineer")
        XCTAssertTrue(json["age"]  == nil)
        XCTAssertTrue(json["committer"] == nil)
        XCTAssertTrue(json["weight"] == nil)
    }
    
    func testOneToOneRelationshipFromJSON() {
        var addressJSON = ["street": "Buchanan Street", "poBox": 123, "city": "Glasgow", "country": "UK"]
        var contributorJSON = ["firstname": "John", "address": addressJSON]
        
        // serialize from json
        let contributor:Contributor = self.serializer.fromJSON(contributorJSON, to: Contributor.self)
        
        // assert construction has succeeded
        XCTAssertTrue(contributor.firstname == "John")
        // asssert relationship has succeeded
        XCTAssertTrue(contributor.address?.street == "Buchanan Street")
        XCTAssertTrue(contributor.address?.poBox == 123)
        XCTAssertTrue(contributor.address?.city == "Glasgow")
        XCTAssertTrue(contributor.address?.country == "UK")
    }
    
    func testOneToOneRelationshipToJSON() {
        // construct objects
        let address = Address()
        address.street = "Buchanan Street"
        address.poBox = 123
        address.city = "Glasgow"
        address.country = "UK"
        
        let contributor = Contributor()
        contributor.firstname = "John"
        // assign relationship
        contributor.address = address
        
        // serialize to json
        let json = self.serializer.toJSON(contributor)

        // assert construction has succeeded
        XCTAssertTrue(json["firstname"] as String == "John")
        // asssert relationship has succeeded
        let addressJSON = json["address"] as [String: AnyObject]
        XCTAssertTrue(addressJSON["street"] as String == "Buchanan Street")
        XCTAssertTrue(addressJSON["poBox"] as Int == 123)
        XCTAssertTrue(addressJSON["city"] as String == "Glasgow")
        XCTAssertTrue(addressJSON["country"] as String == "UK")
    }
    
    func testOneToManyRelationshipFromJSON() {
       // construct objects
        var contributorAJSON = ["id": 100, "firstname": "John"]
        var contributorBJSON = ["id": 101, "firstname": "Maria"]
        
        var teamJSON = ["name": "AeroGear", "contributors": [contributorAJSON, contributorBJSON]]
        
        // serialize from json
        let team:Team = self.serializer.fromJSON(teamJSON, to: Team.self)
        
        // assert construction has succeeded
        XCTAssertTrue(team.name == "AeroGear")
        // asssert one-to-many relationship has succeeded
        XCTAssertTrue(team.contributors?.count == 2)
        
        // verify each object
        let contributorA = team.contributors?[0]
        XCTAssertTrue(contributorA?.id == 100)
        XCTAssertTrue(contributorA?.firstname == "John")
        
        let contributorB = team.contributors?[1]
        XCTAssertTrue(contributorB?.id == 101)
        XCTAssertTrue(contributorB?.firstname == "Maria")
    }
    
    func testOneToManyRelationshipToJSON() {
        // construct objects
        let contributorA = Contributor()
        contributorA.id = 100
        contributorA.firstname = "John"
        
        let contributorB = Contributor()
        contributorB.id = 101
        contributorB.firstname = "Maria"
        
        let team = Team()
        team.name = "AeroGear"
        // assign relationship
        team.contributors = [contributorA, contributorB]
        
        // serialize to json
        let json = self.serializer.toJSON(team)
        
        // assert construction has succeeded
        XCTAssertTrue(json["name"] as String == "AeroGear")
        // asssert relationship has succeeded
        let contributorsJSON = json["contributors"] as [[String: AnyObject]]

        let contributorAJSON = contributorsJSON[0] as [String: AnyObject]
        XCTAssertTrue(contributorAJSON["id"] as Int == 100)
        XCTAssertTrue(contributorAJSON["firstname"] as String == "John")

        let contributorBJSON = contributorsJSON[1] as [String: AnyObject]
        XCTAssertTrue(contributorBJSON["id"] as Int == 101)
        XCTAssertTrue(contributorBJSON["firstname"] as String == "Maria")
    }
    
    func testMapArrayJSON(){
        
        let arrayJSONString = "[{\"firstname\": \"Elisa\", \"id\": \"2\", \"age\": 54},{ \"firstname\": \"Mireille\", \"id\": \"3\", \"age\": 25,}]"
        
        let studentArray: [Contributor!]? = self.serializer.fromJSONArray(arrayJSONString, to: Contributor.self)

        XCTAssert(studentArray?.count == 2, "There should be 2 students in array")
        XCTAssert(studentArray?[0].firstname == "Elisa", "First student's does not match")
        XCTAssert(studentArray?[1].firstname == "Mireille", "Second student's does not match")

    }
}
