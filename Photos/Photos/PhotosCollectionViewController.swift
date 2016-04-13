//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]!
    var pics: [UIImage]!
   // var completionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        layout.itemSize = CGSize(width: 160, height: 180)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.photos != nil {
            return self.photos.count
        } else {
            return 0
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedPhoto = SpecificViewController()
        selectedPhoto.img = self.pics[indexPath.item]
        selectedPhoto.url = self.photos[indexPath.item].urlHQ
        selectedPhoto.name = self.photos[indexPath.item].username
        selectedPhoto.like = String(self.photos[indexPath.item].likes)
        self.navigationController?.pushViewController(selectedPhoto, animated: true)
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
            if let items = photos {
                cell.backgroundColor = UIColor.whiteColor()
                let photo = items[indexPath.item]
                cell.nameTextLabel?.text = photo.username
                var likesString: String
                likesString = numLikesToString(photo.likes)
                cell.likesTextLabel?.text = likesString
                cell.imageView?.image = self.pics[indexPath.item]
                cell.imageView.setNeedsDisplay()
            }
            return cell
    }
    
    func numLikesToString (num: Int) -> String {
        var result: String
        if (num < 1000) {
            result = String(num)
        } else if (num < 10000) {
            result = String(num/1000) + "," + String(num%1000)
        } else if (num < 1000000) {
            result = String(num/1000) + "k"
        } else {
            result = String(num/1000000) + "m"
        }
        return result
    }
    
    func appendToPhoto(img: UIImage, index: Int) {
        self.pics[index] = img
    }
    
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage.
    It then sets this as the imageView's image. */
    func loadImageForCell(url: String, index: Int, callback: (UIImage, Int) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                callback(UIImage.init(data: data!)!, index)
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.photos.sortInPlace({ $0.likes > $1.likes })
        self.collectionView!.reloadData()
        self.pics = [UIImage](count: photos.count, repeatedValue: UIImage())
        for (index, photo) in self.photos.enumerate() {
            self.loadImageForCell(photo.url, index: index, callback: self.appendToPhoto)
        }
    }
    
}

class CollectionViewCell: UICollectionViewCell {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    var nameTextLabel: UILabel!
    var likesTextLabel: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 20))
        contentView.addSubview(imageView)
        
        let likeTextFrame = CGRect(x: 100, y: 144, width: frame.size.width/3, height: frame.size.height/4)
        likesTextLabel = UILabel(frame: likeTextFrame)
        likesTextLabel.font = likesTextLabel.font.fontWithSize(14)
        likesTextLabel.textAlignment = .Right
        contentView.addSubview(likesTextLabel)
        
        let nameTextFrame = CGRect(x: 2, y: 144, width: frame.size.width - frame.size.width/4.7, height: frame.size.height/4)
        nameTextLabel = UILabel(frame: nameTextFrame)
        nameTextLabel.font = nameTextLabel.font.fontWithSize(14)
        nameTextLabel.textAlignment = .Left
        contentView.addSubview(nameTextLabel)
    }
}


