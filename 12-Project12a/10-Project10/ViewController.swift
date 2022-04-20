import UIKit

class ViewController: UICollectionViewController {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItem()
        setupUserDefaults()
    }

    private func addNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                           target: self,
                                                           action: #selector(addNewPerson))
    }

    @objc private func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    private func setupUserDefaults()
    {
        //to load the array back from disk when the app runs
        let defaults = UserDefaults.standard

        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodedPeople
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("unable to dequeue person cell")
        }

        //because is a grid it has items instead
        let person = people[indexPath.item]

        cell.name.text = person.name

        let path = getDocumentDirectory().appendingPathComponent(person.image)

        cell.imageView.image = UIImage(contentsOfFile: path.path)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            self?.save()

            self?.collectionView.reloadData()
        })

        present(ac, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //read image
        guard let image = info[.editedImage] as? UIImage else {
            return
        }

        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknow", image: imageName)
        people.append(person)
        save()

        collectionView.reloadData()

        dismiss(animated: true, completion: nil)
    }

    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory,
                                              in: .userDomainMask)
        return path[0]
    }

    func save()
    {
        //transform an object graph into a Data object using those NSCoding
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people,
                                                             requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
}
