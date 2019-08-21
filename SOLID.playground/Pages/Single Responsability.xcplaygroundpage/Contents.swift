/*:
 ## Singles Responsability
 
 A class should not contain multiples reasons to change
 */
import Foundation

enum SomeError: LocalizedError {
    case someWentWrong
}

class User {
    func createPost(_ post: String) {
        do {
            try addPostToDatabase(post)
        } catch (let error) {
            logErrorToDataBase(error)
            writeLogErrorOnDisk(error)
        }
    }
    
    func addPostToDatabase(_ post: String) throws {
        // Add post to the database
    }
    
    func logErrorToDataBase(_ error: Error) {
        // Handle the error
    }
    
    func writeLogErrorOnDisk(_ error: Error) {
        // Write error on disk
    }
}
/*:
 ### Refactor 1
 */
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

struct _Post {
    func createPost(_ post: String) {
        let database = Database()
        do {
            try database.addPost(post)
        } catch let error {
            database.logError(error)
            FileSystem.writeError(error)
        }
    }
}
/*:
 ### Refactor 2
*/
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
//: [Next](@next)
