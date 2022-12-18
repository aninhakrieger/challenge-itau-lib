//
//  ChallengeItauTests.swift
//  ChallengeItauTests
//
//  Created by Ana Krieger on 17/12/22.
//

import XCTest
@testable import ChallengeItau

final class ChallengeItauTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInteractor() {
        let interactor = SendInformationIteractor(viewController: HomeViewController())
        let bootTime = interactor.bootTime()
        XCTAssertTrue(bootTime != nil)
    }

}
