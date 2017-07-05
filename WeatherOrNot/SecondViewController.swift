//
//  SecondViewController.swift
//  WeatherOrNot
//
//  Created by Remigio, Kevin (Contractor) on 6/14/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var weatherPaginatedVC: WeatherPageViewController? = nil
    var addButton: UIButton? = nil
    var callButton: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppUtility.sharedInstance.getRandomColor().withAlphaComponent(0.3)
        let containerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 40)
        
        weatherPaginatedVC = WeatherPageViewController()
        
        addChildViewController(weatherPaginatedVC!)
        weatherPaginatedVC?.view.frame = containerFrame
        
        view.addSubview(weatherPaginatedVC!.view)
        weatherPaginatedVC?.didMove(toParentViewController: self)
        
        let addButtonFrame = CGRect(x: view.frame.width - 48, y: view.frame.height - 40, width: 48, height: 34)
        addButton = UIButton(frame: addButtonFrame)
        addButton?.titleLabel!.font =  UIFont(name: "PingFangTC-Light", size: 32)
        addButton?.setTitle("+", for: .normal)
        addButton?.setTitleColor(UIColor.blue, for: .normal)
        addButton?.addTarget(self, action: (#selector(SecondViewController.addNewViewPage)), for: .touchUpInside)
        
        let callButtonFrame = CGRect(x: 8, y: view.frame.height - 38, width:100, height: 34)
        callButton = UIButton(frame: callButtonFrame)
        callButton?.titleLabel!.font =  UIFont(name: "PingFangTC-Light", size: 20)
        callButton?.setTitle("call kevin", for: .normal)
        callButton?.setTitleColor(UIColor.blue, for: .normal)
        callButton?.addTarget(self, action: (#selector(SecondViewController.callKevin)), for: .touchUpInside)
        view.addSubview(callButton!)
        
        view.addSubview(addButton!)
        
        
        
    }

    func callKevin() {

        let numberr = "8324831467"
        guard let number = URL(string: "tel://" + numberr) else { return }
        UIApplication.shared.open(number)
        
//        let alertController = UIAlertController(title: "Call Kevin", message: "Time to share your feelings with Kevin", preferredStyle: .alert)
//        
//        let OKAction = UIAlertAction(title: "Call", style: .default) { action in
//            // ...
//            let numberr = "8324831467"
//            guard let number = URL(string: "tel://" + numberr) else { return }
//            UIApplication.shared.open(number)
//        }
//        let Cancel = UIAlertAction(title: "Meh..", style: .cancel) { action in
//            // ...
//        }
//        alertController.addAction(OKAction)
//        alertController.addAction(Cancel)
//        
//        self.present(alertController, animated: true) {
//            // ...
//        }
    }

    func addNewViewPage() {
        view.backgroundColor = AppUtility.sharedInstance.getRandomColor().withAlphaComponent(0.3)
        let alertController = UIAlertController(title: "This is embarassing", message: "my album coming soon", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "sure, dude", style: .default) { action in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }

}
