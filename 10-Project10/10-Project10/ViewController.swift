import UIKit

class ViewController: UICollectionViewController {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItem()
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName

            self?.collectionView.reloadData()
        })

        present(ac, animated: true)
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

        collectionView.reloadData()

        dismiss(animated: true, completion: nil)
    }

    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory,
                                              in: .userDomainMask)
        return path[0]
    }
}
