//
//  ExtractIngredientsTests.swift
//  ChallengeTests
//
//  Created by Mohamed Eltaweel on 26/01/2022.
//

import XCTest
@testable import Challenge

class ExtractIngredientsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExtractingIngredientsFromCorrectInput(){
        let userInput = "1 cup rice,\n3 cup water"
        let service = ExtractIngredients(ingredientsDelimeter: ",", ingredientDelimeter: " ")
        let ingredients = service.extractIngredients(userInput: userInput)
        print("Ingredients : \(ingredients)")
        XCTAssertTrue(ingredients.count == 2)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
