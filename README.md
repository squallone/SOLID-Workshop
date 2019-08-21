 ## SOLID Principles
 
 The SOLID principles tell us how to arrange our functions and data structures into classes, modules, compmentes, and how those classes should be interconnected
 
 The goal is the creation of mid-level software structures that:
 
 - Tolerate change,
 - Are easy to understand
 - Are the basis of components that can be used in many software systems.
 
 ## Principles
 
 - **SRP**: The Single Responsibility Principle
 An active corollary to Conway’s law: The best structure for a software system is heavily influenced by the social structure of the organization that uses it so that each software module has one, and only one, reason to change.
 
 ```swift
 
 struct Database {
     func addPost(_ post: String) throws {
        // Add post to the database
     }
     func logError(_ error: Error) {
        // Handle the error
     }
 }
 
 struct FileSystem {
     static func writeError(_ error: Error) {
        // Write error
     }
 }
 
 struct ErrorLogger {
     let database: Database
     
     init(database: Database) {
        self.database = database
     }
     
     func log(_ error: Error) {
        database.logError(error)
        FileSystem.writeError(error)
     }
 }
 
 struct PostHandler {
     private let database: Database
     private let errorLogger: ErrorLogger
     
     init(database: Database, errorLogger: ErrorLogger) {
        self.database = database
        self.errorLogger = errorLogger
        }
 
     func createPost(_ post: String) {
         do {
            try database.addPost(post)
         } catch let error {
            errorLogger.log(error)
         }
     }
 }
 
 ```
 - **OCP**: The Open-Closed Principle
 Bertrand Meyer made this principle famous in the 1980s. The gist is that for software systems to be easy to change, they must be designed to allow the behavior of those systems to be changed by adding new code, rather than changing existing code.
 
 ```swift
 
 protocol Shape {
    func draw()
 }
 
 struct Circle: Shape {
     let type: ShapeType
     let radius: Double
     let center: CGPoint
     
     func draw() {
        print("draw the circle - Refactor 1")
     }
 }
 
 struct Square: Shape {
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
 
 
 struct Drawer {
     func drawShapes(_ shapes: [Shape]) {
         for shape in shapes {
            shape.draw()
         }
     }
 }
 
 let circle = Circle(type: .circle, radius: 1.0, center: .zero)
 let square = Square(type: .square, side: 2.0, topLeft: .zero)
 let traingle = Triangle(type: .triangle, side: 2.0, topLeft: .zero)
 
 let drawer2 = _Drawer()
 drawer2.drawShapes([circle, square, traingle])
 
 ```
 
- **LSP**: The Liskov Substitution Principle
 Barbara Liskov’s famous definition of subtypes, from 1988. In short, this principle says that to build software systems from interchangeable parts, those parts must adhere to a contract that allows those parts to be substituted one for another.
 
 ```swift
 protocol Polygon {
    var area: Float { get }
 }
 
 final class Rectangle: Polygon {
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
 
 final class Square: Polygon {
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
 
 let rectangle = Rectangle(width: 2, length: 5)
 printArea(of: rectangle) // 10
 
 let square = Square(side: 2)
 printArea(of: square) // 4
 
 ```
 
 - **ISP**: The Interface Segregation Principle
 This principle advises software designers to avoid depending on things that they don’t use.
 
 ```swift
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
 ```
 
 - **DIP**: The Dependency Inversion Principle
 The code that implements high-level policy should not depend on the code that implements low-level details. Rather, details should depend on policies.
 These principles have been described in detail in many different publications1 over the years.
 
 ```swift
 
 final class Handler {
     let storage: Storage
     
     init(storage: Storage) {
        self.storage = storage
     }
 
     func handle(string: String) {
        storage.write()
        }
     }
 
     protocol Storage {
        func write()
     }
 
 final class FileSystemManager: Storage {
     func write() {
        // Write
     }
 }
 
 final class MemoryMock: Storage {
     func write() {
        // Handler string into memory
     }
 }
 ```
 
