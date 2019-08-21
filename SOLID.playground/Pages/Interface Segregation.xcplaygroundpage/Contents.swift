//: [Previous](@previous)
/*:
 ## Interface Segration Principle
 Clients should not be forced to depend on methods that they do not use.
 */
import Foundation

protocol LogStyle {
    func lowerCase()
    func upperCase()
    func capitalized()
}

class Logger: LogStyle {
    func lowerCase() {
        // Implement here
    }
    func upperCase() {
        // Implement
    }
    func capitalized() {
        
    }
}

class LoggerLowerCase: LogStyle {
    func lowerCase() {
        // Implement here
    }
    
    func upperCase() {
        // Not used
    }
    func capitalized() {
        // Not used
    }
}

class UpperCasee: LogStyle {
    func lowerCase() {
    }
    
    func upperCase() {
        // This is used
    }
    func capitalized() {
        // Not used
    }
}

protocol LogStyleLowerCase {
    func lowerCase()
}

protocol LogStyleUpperCase {
    func upperCase()
}

protocol LogStyleCapitized {
    func capitalized()
}

class LoggerLowerCaseAndUpperCase: LogStyleLowerCase, LogStyleUpperCase {
    func lowerCase() {
        // Implement here
    }
    
    func upperCase() {
        // Not used
    }
}
//: [Next](@next)
