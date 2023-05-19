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
                //print(persistentStoreDescription.url)
                self?.fetchBooks()

                //print(persistentStoreDescription.url, persistentStoreDescription.type)
            }
        }

        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave,
                                               object: persistentContainer.viewContext,
                                               queue: .main){ [weak self] _ in
            self?.fetchBooks()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddBookViewController {
            viewController.managedObjectContext = persistentContainer.viewContext
        }
    }

    private func fetchBooks() {
        //print(persistentContainer.viewContext)
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()

        persistentContainer.viewContext.perform {
            do {
                let result = try fetchRequest.execute()

                self.booksLabel.text = "\(result.count) Books"
            } catch {
                print("unable to execute fetch request, \(error)")
            }
        }
    }
    
}
