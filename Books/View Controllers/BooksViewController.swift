import UIKit
import CoreData

final class BooksViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private var booksLabel: UILabel!

    private lazy var persistentContainer: NSPersistentContainer = {
        NSPersistentContainer(name: "Books")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error  in
            if let error = error {
                print("unable to add persistent store")
                print("\(error), \(error.localizedDescription)")
            } else {
                self?.fetchBooks()
                //print(persistentStoreDescription.url, persistentStoreDescription.type)
            }
        }
    }

    private func fetchBooks() {
        print(persistentContainer.viewContext)
    }
    
}
