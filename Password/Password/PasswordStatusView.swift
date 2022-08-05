import UIKit

class PasswordStatusView: UIView {
    
    let stackView = UIStackView()
    
    let criticalLabel = UILabel()
    
    let lengthCriteriaView = PasswordCriterialView(text: "8-32 characters (no spaces)")
    let uppercaseCriticalView = PasswordCriterialView(text: "uppercase letter (A-Z)")
    let lowercaseCriteriaView = PasswordCriterialView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriterialView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriterialView(text: "special character (e.g. !@#$%^&)")
    
    // Used to determine if we reset criteria to empty state.
    var shouldResetCriteria: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension PasswordStatusView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        criticalLabel.numberOfLines = 0
        criticalLabel.lineBreakMode = .byWordWrapping
        criticalLabel.attributedText = makeCriteriaMessage()
    }
    
    func layout() {
        
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criticalLabel)
        stackView.addArrangedSubview(uppercaseCriticalView)
        stackView.addArrangedSubview(lowercaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
    }
    
    func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        
        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))
        
        return attrText
    }
}

extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthCriteriaMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        if shouldResetCriteria {
            // Inline validation (✅ or ⚪️)
            lengthAndNoSpaceMet
            ? lengthCriteriaView.isCriterialMet = true
            : lengthCriteriaView.reset()
            
            uppercaseMet
            ? uppercaseCriticalView.isCriterialMet = true
            : uppercaseCriticalView.reset()
            
            lowercaseMet
            ? lowercaseCriteriaView.isCriterialMet = true
            : lowercaseCriteriaView.reset()
            
            digitMet
            ? digitCriteriaView.isCriterialMet = true
            : digitCriteriaView.reset()
            
            specialCharacterMet
            ? specialCharacterCriteriaView.isCriterialMet = true
            : specialCharacterCriteriaView.reset()
        } else {
            lengthCriteriaView.isCriterialMet = lengthAndNoSpaceMet
            uppercaseCriticalView.isCriterialMet = uppercaseMet
            lowercaseCriteriaView.isCriterialMet = lowercaseMet
            digitCriteriaView.isCriterialMet = digitMet
            specialCharacterCriteriaView.isCriterialMet = specialCharacterMet
        }
    }
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        let checkable = [uppercaseMet, lowercaseMet, digitMet, specialCharacterMet]
        let metCriteria = checkable.filter { $0 }
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        
        if lengthAndNoSpaceMet && metCriteria.count >= 3 {
            return true
        }
        
        return false
    }
    
    func reset() {
        lengthCriteriaView.reset()
        uppercaseCriticalView.reset()
        lowercaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }
}
