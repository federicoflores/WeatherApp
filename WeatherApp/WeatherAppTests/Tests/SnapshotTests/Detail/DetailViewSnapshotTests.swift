//
//  DetailViewSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Fede Flores on 03/03/2024.
//

import XCTest
import SnapshotTesting

final class DetailViewSnapshotTests: XCTestCase {
    
    var sut: UIViewController?

    override func setUpWithError() throws {
        sut = DetailModuleBuilderStub.build()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testDetailViewController() {
        guard let sut = sut else { return }
        assertSnapshot(of: sut, as: .image)
    }

    

}
