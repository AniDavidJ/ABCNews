//
//  GlobalClass.swift
//  ABCNews
//
//  Created by ani david on 10/10/20.
//  Copyright © 2020 ani david. All rights reserved.
//
import UIKit
import SwiftyJSON
import Moya
import Alamofire
import SVProgressHUD

struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT == 812.0
    static let IS_IPHONE_XP         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT > 812.0
    
    // static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT > 896.0
    
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}
class GlobalClass: NSObject {


 class func showAlertDialog(message: String, target: UIViewController){
    
    if message != "Success Alert"
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        
        print(message)
        if message == "Token is not valid"  {
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: { _ -> Void in
                
            }))
        } else if message == "The Internet connection appears to be offline." || message == "The request timed out." {
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: { _ -> Void in
                
                
            }))
        }
        else {
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in }))
        }
        target.present(alert, animated: true, completion: nil)
    }
    else{
        
        let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: "Successfully submit Feedback Form", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: { _ -> Void in
            
        }))
        
        target.present(alert, animated: true, completion: nil)
    }
}
}
