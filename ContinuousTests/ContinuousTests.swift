//
//  ContinuousTests.swift
//  ContinuousTests
//
//  Created by Chloe on 2016-03-19.
//  Copyright © 2016 Chloe Horgan. All rights reserved.
//

import XCTest
@testable import Continuous


class ContinuousTests: XCTestCase {
    
    var date1: NSDate?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let comp = NSDateComponents()
        comp.day = 19
        comp.month = 3
        comp.year = 2016
        date1 = NSCalendar.currentCalendar().dateFromComponents(comp)!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDatesWithinSameDay() {
        let comp = NSDateComponents()
        comp.day = 19
        comp.month = 3
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertTrue(DateComparison.isSameDay(date1!, date2: date2))
    }
    
    func testDatesWithinDifferentDays() {
        let comp = NSDateComponents()
        comp.day = 5
        comp.month = 3
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertFalse(DateComparison.isSameDay(date1!, date2: date2))
    }
    
    func testDatesWithinSameWeek() {
        let comp = NSDateComponents()
        comp.day = 14
        comp.month = 3
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertTrue(DateComparison.isSameWeek(date1!, date2: date2))
    }
    
    func testDatesWithinDifferentWeeks() {
        let comp = NSDateComponents()
        comp.day = 5
        comp.month = 3
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertFalse(DateComparison.isSameWeek(date1!, date2: date2))
    }
    
    func testDatesWithinSameMonth() {
        let comp = NSDateComponents()
        comp.day = 14
        comp.month = 3
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertTrue(DateComparison.isSameMonth(date1!, date2: date2))
    }
    
    func testDatesWithinDifferentMonths() {
        let comp = NSDateComponents()
        comp.day = 5
        comp.month = 2
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertFalse(DateComparison.isSameMonth(date1!, date2: date2))
    }
    
    func testDatesWithinSameYear() {
        let comp = NSDateComponents()
        comp.day = 14
        comp.month = 3
        comp.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertTrue(DateComparison.isSameYear(date1!, date2: date2))
    }
    
    func testDatesWithinDifferentYears() {
        let comp = NSDateComponents()
        comp.day = 5
        comp.month = 3
        comp.year = 2015
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp)!
        
        XCTAssertFalse(DateComparison.isSameYear(date1!, date2: date2))
    }
    
    func testDatesWithinSameWeekSpanningDifferentYears() {
        let comp0 = NSDateComponents()
        comp0.day = 31
        comp0.month = 12
        comp0.year = 2015
        let date0 = NSCalendar.currentCalendar().dateFromComponents(comp0)!
        
        let comp2 = NSDateComponents()
        comp2.day = 2
        comp2.month = 1
        comp2.year = 2016
        let date2 = NSCalendar.currentCalendar().dateFromComponents(comp2)!
        
        XCTAssertFalse(DateComparison.isSameYear(date0, date2: date2))
    }

}
