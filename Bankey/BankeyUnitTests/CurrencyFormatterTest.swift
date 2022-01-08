import Foundation
import XCTest

@testable import Bankey

class CurrencyFormatterTests: XCTestCase {
    var formatter: CurrencyFormatter!
    let customCurrency = "$"
    let customLocale = "en_US"
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter(withCustomLocale: customLocale, withCurrency: customCurrency)
    }
    
    func testBreakCurrencyIntoPenny() throws {
        let result = formatter.breakIntoDecimalAndFraction(929466.23)
        let currencyWithDecimal = result.0
        let fraction = result.1
        
        XCTAssertEqual(currencyWithDecimal, "929,466")
        XCTAssertEqual(fraction, "23")
    }
}
