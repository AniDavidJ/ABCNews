//
//  newsDescriptionViewController.swift
//  ABCNews
//
//  Created by ani david on 10/10/20.
//  Copyright © 2020 ani david. All rights reserved.
//

import UIKit
import SwiftyJSON
import WebKit
import SVProgressHUD


class newsDescriptionViewController: UIViewController,WKNavigationDelegate {
    var newsdecriptionValue                      = JSON()
    
    
    @IBOutlet weak var NewsImageView: UIImageView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel2: UILabel!
    
    @IBOutlet weak var saveImageButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsImageView.layer.cornerRadius    = 2
        NewsImageView.clipsToBounds         = true
        saveImageButton.layer.cornerRadius    = 2
        saveImageButton.clipsToBounds         = true
        saveImageButton.layer.borderWidth = 1
        saveImageButton.layer.borderColor = UIColor.darkGray.cgColor
        
        DescriptionLabel.text = newsdecriptionValue["title"].stringValue
        authorLabel.text = newsdecriptionValue["author"].stringValue
        NewsImageView.sd_setImage(with: URL(string: newsdecriptionValue["urlToImage"].stringValue), placeholderImage: #imageLiteral(resourceName: "Avatar"))
        contentLabel.text = newsdecriptionValue["description"].stringValue
        contentLabel2.text = newsdecriptionValue["content"].stringValue 
        publishDateLabel.text = convertDateFormater(date:  newsdecriptionValue["publishedAt"].stringValue)
    }
    
    //MARK:- button Action
    
    @IBAction func shareWithFriendsAction(_ sender: Any) {
        self.showShareActivity(msg: newsdecriptionValue["url"].stringValue, image: nil, url: nil, sourceRect: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func SaveImageAction(_ sender: Any) {
        let success = saveImage(image: NewsImageView.image ?? #imageLiteral(resourceName: "Avatar"))
        let str = newsdecriptionValue["publishedAt"].stringValue
        if let image = getSavedImage(named: "newsImage\(str)") {
            print("yes available")
            
        }
        GlobalClass.showAlertDialog(message: "Your image has been saved successfully ", target: self)
    }
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            let str = newsdecriptionValue["publishedAt"].stringValue
            try data.write(to: directory.appendingPathComponent("newsImage\(str).png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            print(URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    //MARK:- Date Converter
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "dd MMM,yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect:CGRect?){
        var objectsToShare = [AnyObject]()
        
        if let url = url {
            objectsToShare = [url as AnyObject]
        }
        
        if let image = image {
            objectsToShare = [image as AnyObject]
        }
        
        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        
        topViewController().present(activityVC, animated: true, completion: nil)
    }
    func topViewController()-> UIViewController{
        var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        
        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }
        
        return topViewController
    }
}
