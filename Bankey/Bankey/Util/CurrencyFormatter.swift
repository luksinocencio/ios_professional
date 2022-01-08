import UIKit

struct CurrencyFormatter {
    
    let currencySymbol: String
    let customLocale: String
    
    private var customNumberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: customLocale)
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol
        
        return formatter
    }
    
    /// Locale's currency symbol still can be nil
    /// therefore as a default you it will use $
    init() {
        self.currencySymbol = NSLocale.current.currencySymbol ?? "$"
        self.customLocale = NSLocale.current.languageCode ?? "en_US"
    }
    
    /// You can init with custom locale and currency symbol
    init(withCustomLocale locale: String, withCurrency currencySymbol: String) {
        self.currencySymbol = currencySymbol
        self.customLocale = locale
    }
    
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoDecimalAndFraction(amount)
        return makeBalanceAttributed(currency: tuple.0, fraction: tuple.1)
    }
    
    // Converts 929466.23 > "929,466" "23"
    func breakIntoDecimalAndFraction(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let decimal = convertCurrency(withDecimal: tuple.0)
        let fraction = convertFraction(tuple.1)
        
        return (decimal, fraction)
    }
    
    // Converts 929466 > 929,466
    private func convertCurrency(withDecimal decimalPart: Double) -> String {
        let currencyWithDecimal = formatCurrency(decimalPart) // "$929,466.00"
        
        let decimalSeparator = customNumberFormatter.decimalSeparator! // "."
        let decimalParts = currencyWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        var currency = decimalParts.first! // "$929,466"
        currency.removeFirst() // "929,466"
        
        return currency
    }
    
    // Convert 0.23 > 23
    private func convertFraction(_ fractionPart: Double) -> String {
        let fraction: String
        if fractionPart == 0 {
            fraction = "00"
        } else {
            fraction = String(format: "%.0f", fractionPart * 100)
        }
        return fraction
    }
    
    // Converts 929466 > $929,466.00
    func formatCurrency(_ currency: Double) -> String {
        if let result = customNumberFormatter.string(from: NSNumber(value: currency)) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAttributed(currency: String, fraction: String) -> NSMutableAttributedString {
        let currencySymbolAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let currencyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let fractionAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: self.currencySymbol, attributes: currencySymbolAttributes)
        let currencyString = NSAttributedString(string: currency, attributes: currencyAttributes)
        let fractionString = NSAttributedString(string: fraction, attributes: fractionAttributes)
        
        rootString.append(currencyString)
        rootString.append(fractionString)
        
        return rootString
    }
}
