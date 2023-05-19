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
                print(persistentStoreDescription.url)
                self?.fetchBooks()

                //print(persistentStoreDescription.url, persistentStoreDescription.type)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddBookViewController {
            viewController.managedObjectContext = persistentContainer.viewContext
        }
    }

    private func fetchBooks() {
        print(persistentContainer.viewContext)
    }
    
}
