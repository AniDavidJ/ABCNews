//
//  ViewController.swift
//  ABCNews
//
//  Created by ani david on 09/10/20.
//  Copyright © 2020 ani david. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire
import SDWebImage



class newsListCell: UITableViewCell{
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageUrlImageView: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
        imageUrlImageView.layer.cornerRadius    = 2
        imageUrlImageView.clipsToBounds         = true
    }
    
}
class NewsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var newsListTableView: UITableView!
    var newsValues                      = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.IS_IPHONE_X || DeviceType.IS_IPHONE_XP{
                   
                   
               }else{
                   
                   tableViewBottomConstraint.constant = 10
               }
        news()
        // }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsValues.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newslistcell = newsListTableView.dequeueReusableCell(withIdentifier: "newsListCell") as! newsListCell
        newslistcell.descriptionLabel.text = newsValues[indexPath.row]["title"].stringValue
      //  newslistcell.imageUrlImageView.sd_setImage(with: URL(string: newsValues[indexPath.row]["urlToImage"].stringValue), placeholderImage: #imageLiteral(resourceName: "Avatar"))
        newslistcell.imageUrlImageView.sd_setImage(with: URL(string: newsValues[indexPath.row]["urlToImage"].stringValue), placeholderImage: #imageLiteral(resourceName: "Avatar"))
        return newslistcell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard          = UIStoryboard(name: "Main", bundle: nil)
        let newsDescriptionVC  = storyBoard.instantiateViewController(withIdentifier: "newsDescriptionViewController") as! newsDescriptionViewController
        print(newsValues[indexPath.row])
        newsDescriptionVC.newsdecriptionValue = newsValues[indexPath.row]
        self.navigationController?.pushViewController(newsDescriptionVC, animated: true)
    }
    
    func news(){
        SVProgressHUD.show(withStatus: "Loading...")
        var request = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=d29d58aab88d4ea0b04ddb245a230068")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
            
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                   // print(json)
                    // handle json...
                    
                    DispatchQueue.main.async {
                        
                        let jsonVal = JSON(json)
                        if jsonVal["status"].string == "ok"
                        {
                            SVProgressHUD.dismiss()

                        self.newsValues = jsonVal["articles"]
                            print(self.newsValues)
                        self.newsListTableView.reloadData()
                        }
                        
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        
        
    }
}

