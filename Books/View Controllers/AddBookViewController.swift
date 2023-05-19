import UIKit
import CoreData

final class AddBookViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var authorTextField: UITextField!

    // MARK: - Actions

    var managedObjectContext: NSManagedObjectContext?

    @IBAction func addBook(_ sender: Any) {
        guard let managedObjectContext = managedObjectContext else {
            fatalError("No Managed object context available")
        }

        let book = Book(context: managedObjectContext)

        book.title = titleTextField.text
        book.author = authorTextField.text

        do {
            try managedObjectContext.save()

            dismiss(animated: true)
        } catch {
            print("unable to save Book, \(error)")
        }
    }

}
