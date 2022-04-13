import UIKit

class Person: NSObject, NSCoding {
    func encode(with coder: NSCoder)
    {

    }

    var name: String
    var image: String

    required init?(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
