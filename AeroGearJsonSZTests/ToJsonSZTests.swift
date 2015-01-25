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

class ToJsonSZTests: XCTestCase {
    
    var serializer: Serializer!
    
    override func setUp() {
        super.setUp()
        
        serializer = Serializer()
    }
    
    override func tearDown() {
        super.tearDown()
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
        let json = self.serializer.toJson(contributor)
        
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
    
    
    
    func testObjectModelToJSONWithPrimitiveAttributesAndMissingValues() {
        // construct object
        let contributor = Contributor()
        contributor.id = 100
        contributor.title = "Software Engineer"
        
        // serialize to json
        let json = self.serializer.toJson(contributor)
        
        // assert json dictionary has been populated
        XCTAssertTrue(json["id"] as? Int == 100)
        XCTAssertTrue(json["firstname"] == nil)
        XCTAssertTrue(json["lastname"] == nil)
        XCTAssertTrue(json["title"] as? String == "Software Engineer")
        XCTAssertTrue(json["age"]  == nil)
        XCTAssertTrue(json["committer"] == nil)
        XCTAssertTrue(json["weight"] == nil)
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
        let json = self.serializer.toJson(contributor)
        
        // assert construction has succeeded
        XCTAssertTrue(json["firstname"] as String == "John")
        // asssert relationship has succeeded
        let addressJSON = json["address"] as [String: AnyObject]
        XCTAssertTrue(addressJSON["street"] as String == "Buchanan Street")
        XCTAssertTrue(addressJSON["poBox"] as Int == 123)
        XCTAssertTrue(addressJSON["city"] as String == "Glasgow")
        XCTAssertTrue(addressJSON["country"] as String == "UK")
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
        let json = self.serializer.toJson(team)
        
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
    
}
