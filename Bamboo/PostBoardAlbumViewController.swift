//
//  PostBoardAlbumViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 30..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Photos

class PostBoardAlbumViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var smileImageView: UIImageView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    var photos = [UIImage]()
    let totalImageCountNeeded = 100
    var selectedPhoto : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPhotos()
    }
    
    func settingPhotos() {
        photos = []
        fetchPhotoAtIndexFromEnd(0)
    }
    
    func fetchPhotoAtIndexFromEnd(index:Int) {
        
        let imgManager = PHImageManager.defaultManager()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        let fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            imgManager.requestImageForAsset(fetchResult.objectAtIndex(fetchResult.count - 1 - index) as! PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.AspectFill, options: requestOptions, resultHandler: { (image, _) in
                self.photos.append(image!)
                if index + 1 < fetchResult.count && self.photos.count < self.totalImageCountNeeded {
                    self.fetchPhotoAtIndexFromEnd(index + 1)
                } else {
                }
            })
        }
    }
    
    @IBAction func backButtonClicked(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "SavePhoto" {
            if selectedPhoto == nil {
                print("선택된 사진 없음, 얼럴트창 구현해야함")
                return false
            }else {
                return true
            }
        }
        return false
    }
}

extension PostBoardAlbumViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageViewCell.image = photos[indexPath.item]
        
        return cell
    }
}

extension PostBoardAlbumViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.smileImageView.hidden = true
        self.placeHolderLabel.hidden = true
        self.photoImageView.image = photos[indexPath.item]
        self.selectedPhoto = photos[indexPath.item]
    }
}