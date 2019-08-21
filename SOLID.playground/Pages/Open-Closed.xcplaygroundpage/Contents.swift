//: [Previous](@previous)
/*:
 ## Open-Closed Principle
 
 Modules that conform to the open-closed principle have two primary attributes.

 1. They are “Open For Extension”.
 This means that the behavior of the module can be extended. That we can make
 
 the module behave in new and different ways as the requirements of the application change, or to meet the needs of new applications.
 
 2. They are “Closed for Modification”.
 The source code of such a module is inviolate. No one is allowed to make source
 code changes to it.
 */
import Foundation
import UIKit

enum ShapeType {
    case circle
    case square
    case triangle
}

struct Circle {
    let type: ShapeType
    let radius: Double
    let center: CGPoint
    
    func drawCircle() {
        print("draw the circle")
    }
}

struct Square {
    let type: ShapeType
    let side: Double
    let topLeft: CGPoint
    
    func drawSquare() {
        print("draw the square")
    }
}

struct Drawer {
    func drawAllShapes() {
        let circle = Circle(type: .circle, radius: 1.0, center: .zero)
        circle.drawCircle()
        
        let square = Square(type: .square, side: 2.0, topLeft: .zero)
        square.drawSquare()
    }
}

let drawer = Drawer()
drawer.drawAllShapes()
/*:
 ### Refactor 1
 */
protocol Shape {
    func draw()
}

struct _Circle: Shape {
    let type: ShapeType
    let radius: Double
    let center: CGPoint
    
    func draw() {
        print("draw the circle - Refactor 1")
    }
}

struct _Square: Shape {
    let type: ShapeType
    let side: Double
    let topLeft: CGPoint
    
    func draw() {
        print("draw the square - Refactor 1")
    }
}

struct Triangle: Shape {
    let type: ShapeType
    let side: Double
    let topLeft: CGPoint
    
    func draw() {
        print("draw the square - Refactor 1")
    }
}


struct _Drawer {
    func drawShapes(_ shapes: [Shape]) {
        for shape in shapes {
            shape.draw()
        }
    }
}

let circle = _Circle(type: .circle, radius: 1.0, center: .zero)
let square = _Square(type: .square, side: 2.0, topLeft: .zero)
let traingle = Triangle(type: .triangle, side: 2.0, topLeft: .zero)

let drawer2 = _Drawer()
drawer2.drawShapes([circle, square, traingle])


/*:
 ### Example 2
 */

protocol Shooting {
    func shoot() -> String
}

// I'm a laser beam. I can shoot.
struct LaserBeam: Shooting {
    func shoot() -> String {
        return "Ziiiiiip!"
    }
}

// I have weapons and trust me I can fire them all at once. Boom! Boom! Boom!
struct WeaponsComposite {
    let weapons: [Shooting]
    
    init(weapons: [Shooting]) {
        self.weapons = weapons
    }
    
    func shoot() -> [String] {
        return weapons.map { $0.shoot() }
    }
}

let laser = LaserBeam()
var weapons = WeaponsComposite(weapons: [laser])


// Now I create a new weapon, RocketLauncher

final class RocketLauncher: Shooting {
    func shoot() -> String {
        return "Whoosh!"
    }
}

let rocket = RocketLauncher()

weapons = WeaponsComposite(weapons: [laser, rocket])
print(weapons.shoot())
//: [Next](@next)
