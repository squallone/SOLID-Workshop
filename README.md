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
- **LSP**: The Liskov Substitution Principle
 Barbara Liskov’s famous definition of subtypes, from 1988. In short, this principle says that to build software systems from interchangeable parts, those parts must adhere to a contract that allows those parts to be substituted one for another.
 
 - **ISP**: The Interface Segregation Principle
 This principle advises software designers to avoid depending on things that they don’t use.
 
 - **DIP**: The Dependency Inversion Principle
 The code that implements high-level policy should not depend on the code that implements low-level details. Rather, details should depend on policies.
 These principles have been described in detail in many different publications1 over the years.
