//: [Previous](@previous)
/*:
 ## Liskov substitution principle
 The principle defines that objects of a superclass shall be replaceable with objects of its subclasses without breaking the application.
 */

import Foundation

class Rectangle {
    var width: Float = 0
    var length: Float = 0
    
    var area: Float {
        return width * length
    }
}

final class Square: Rectangle {
    override var width: Float {
        didSet {
            length = width
        }
    }
    
    override var area: Float{
        return width * 10
    }
}

final class Printer {
    private func printArea(of rectangle: Rectangle) {
        print(rectangle.area)
    }
    
    func printAreas() {
        let rectangle = Rectangle()
        rectangle.length = 5
        rectangle.width = 2
        printArea(of: rectangle)
        
        let square = Square()
        square.length = 5
        square.width = 2
        printArea(of: square)
    }
}

let printer = Printer()
printer.printAreas()

//: ### Refactor

protocol Polygon {
    var area: Float { get }
}

final class _Rectangle: Polygon {
    private let width: Float
    private let length: Float
    
    init(width: Float, length: Float) {
        self.width = width
        self.length = length
    }
    
    var area: Float {
        return width * length
    }
}

final class _Square: Polygon {
    private let side: Float
    
    init(side: Float) {
        self.side = side
    }
    
    var area: Float {
        return pow(side, 2)
    }
}

// Client Method

func printArea(of polygon: Polygon) {
    print("\(polygon.area)" + "Refactor")
}

// Usage

let rectangle = _Rectangle(width: 2, length: 5)
printArea(of: rectangle) // 10

let square = _Square(side: 2)
printArea(of: square) // 4


/*:
 ## Composition over inheritance
 
 - Separate interfaces instead of creating a hierarchical relationship to distribute behaviors among business-domain classes via inheritance.
 - This approach more easily accommodates future requirements changes that would otherwise require a complete restructuring of business-domain classes in the inheritance model.
- Additionally, it avoids problems often associated with relatively minor changes to an inheritance-based model that includes several generations of classes.
 */

//: [Next](@next)
