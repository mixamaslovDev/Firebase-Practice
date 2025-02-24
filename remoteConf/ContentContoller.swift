//
//  ContentContoller.swift
//  remoteConf
//
//  Created by Михаил Маслов on 27.05.2020.
//  Copyright © 2020 Михаил Маслов. All rights reserved.
//

import UIKit
import Firebase

class ContentContoller: UIViewController {
   
    @IBOutlet weak var remoteImage: UIImageView!
    let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteImage.contentMode = .center
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
           try Auth.auth().signOut()
        }
        catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate() { (error) in
                    let remoteUrl = self.remoteConfig["remoteImage_url"].stringValue
                    self.remoteImage.loadImage(stringUrl: remoteUrl!)
                    print(remoteUrl ?? "")
                    
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
        
    }
    
    
}

extension UIImageView {
    func loadImage(stringUrl: String) {
        DispatchQueue.global().async { [weak self] in
            if let stringUrl = URL(string: stringUrl) {
                if let data = try? Data(contentsOf: stringUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
