import UIKit

class SpecificViewController: UIViewController {
    
    var imageView: UIImageView!
    var nametextLabel: UILabel!
    var likesTextLabel: UILabel!
    var likeButton: UIButton!
    
    var name: String!
    var like: String!
    var img: UIImage!
    var url: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let backView = UIView()
        backView.backgroundColor = UIColor.whiteColor()
        backView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        view.addSubview(backView)
        
        imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 160, width: screenSize.width, height: screenSize.width)
        view.addSubview(imageView)
        
        self.likeButton = UIButton(type: UIButtonType.System) as UIButton
        likeButton.frame = CGRect(x: 300, y: screenSize.width + 160, width: screenSize.width/5, height: 20)
        likeButton.setTitle("Like", forState: UIControlState.Normal)
        
        self.likeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        likeButton.addTarget(self, action: "pressButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(likeButton)
        
        let likesText = CGRect(x: 150, y: screenSize.width + 160, width: screenSize.width/1.5, height: 20)
        likesTextLabel = UILabel(frame: likesText)
        likesTextLabel.textAlignment = .Left
        likesTextLabel.text = self.like + " likes"
        likesTextLabel.font = likesTextLabel.font.fontWithSize(14)
        view.addSubview(likesTextLabel)
        
        let nameText = CGRect(x: 2, y: screenSize.width + 160, width: screenSize.width/1.5, height: 20)
        nametextLabel = UILabel(frame: nameText)
        nametextLabel.textAlignment = .Left
        nametextLabel.text = " " + self.name
        nametextLabel.font = nametextLabel.font.fontWithSize(14)
        view.addSubview(nametextLabel)
    }
    
    func pressButton(sender:UIButton!) {
        
        if (self.likeButton.titleLabel?.textColor == UIColor.blueColor()) {
            self.likeButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            likeButton.setTitle("Liked", forState: UIControlState.Normal)
        } else {
            self.likeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            likeButton.setTitle("Like", forState: UIControlState.Normal)
        }
    }
    
}
