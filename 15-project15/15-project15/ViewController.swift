
import UIKit

class ViewController: UIViewController {
    var currentAnimation = 0

    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "penguin"))
        return image
    }()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        peguinOnView()
    }

    private func peguinOnView()
    {
        //center and add to parent view
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func tapped(_ sender: UIButton)
    {
        sender.isHidden = true
        setupAnimation(sender: sender)
        //add plus 1 to current animation with ech tap
        currentAnimation += 1
        // if currentanimation reaches 7 animations go back to initial
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }

    private func setupAnimation(sender: UIButton)
    {
        //options: type of animation
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: []) {
            switch self.currentAnimation {
            case 0:
                //scale image twice of its size
                self.imageView.transform = CGAffineTransform(scaleX: 2,
                                                             y: 2)
                break
            case 1:
                self.imageView.transform = .identity
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
            case 3:
                self.imageView.transform = .identity
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 5:
                self.imageView.transform = .identity
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.green
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
            default:
                break
            }
        } completion: { finished in
            sender.isHidden = false
        }
    }
}

