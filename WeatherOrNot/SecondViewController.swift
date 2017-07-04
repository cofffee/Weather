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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppUtility.sharedInstance.getRandomColor().withAlphaComponent(0.3)
        let containerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 40)
        
        weatherPaginatedVC = WeatherPageViewController()
        
        addChildViewController(weatherPaginatedVC!)
        weatherPaginatedVC?.view.frame = containerFrame
        
        view.addSubview(weatherPaginatedVC!.view)
        weatherPaginatedVC?.didMove(toParentViewController: self)
        
        let addButtonFrame = CGRect(x: view.frame.width - 48, y: view.frame.height - 36, width: 48, height: 32)
        addButton = UIButton(frame: addButtonFrame)
        addButton?.setTitle("add", for: .normal)
        addButton?.setTitleColor(UIColor.blue, for: .normal)
        addButton?.addTarget(self, action: (#selector(SecondViewController.addNewViewPage)), for: .touchUpInside)
        view.addSubview(addButton!)
        
        
        
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
