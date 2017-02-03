//
//  FenceManagerTests.swift
//  Project_EPN
//
//  Created by Aidan Smith on 2016-09-23.
//  Copyright © 2016 ShamothSoft. All rights reserved.
//

import XCTest
@testable import Project_EPN
import CoreLocation

let kFenceName = "Dyronini's Pizza"
class FenceManagerTests: XCTestCase {
    
    let fenceManager = FenceManager()
    let fence = Fence (name: kFenceName, center: CLLocationCoordinate2DMake(0.0, 0.0), radius: 0.0)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRetrieve() {
        self.fenceManager.fenceList.append(self.fence)
        let fence = fenceManager.fence(at: 0)
        XCTAssert(fence.name == kFenceName)
    }
    
    func testAppend () {
        self.fenceManager.append(self.fence)
        let fence = self.fenceManager.fenceList.first
        XCTAssert(fence?.name == kFenceName)
    }
    
    func testRemove () {
        self.fenceManager.fenceList.append(self.fence)
        self.fenceManager.remove(at: 0)
        XCTAssert(self.fenceManager.fenceList.count == 0)
    }
    
    func testReplace (){
        let newFenceName = "Dyronini's Pasta"
        self.fenceManager.fenceList.append(self.fence)
        self.fenceManager.replace(at: 0, fence: Fence (name: newFenceName, center: CLLocationCoordinate2DMake(1.0, 1.0), radius: 0.1))
        XCTAssert(self.fenceManager.fenceList [0].name == newFenceName)
    }
    
    func testReplaceOutOfBounds (){
        self.fenceManager.fenceList.append(self.fence)
        self.fenceManager.replace(at: 1, fence: Fence (name: "Dyronini's Pasta", center: CLLocationCoordinate2DMake(1.0, 1.0), radius: 0.1))
        XCTAssert(self.fenceManager.fenceList.count == 1)
        XCTAssert(self.fenceManager.fenceList [0].name == kFenceName)
    }
    
    func testRemoveOutOfBounds (){
        self.fenceManager.fenceList.append(self.fence)
        self.fenceManager.remove (at:1)
        XCTAssert(self.fenceManager.fenceList.count == 1)
    }
        
}
