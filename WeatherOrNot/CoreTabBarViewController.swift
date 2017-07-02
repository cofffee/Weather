//
//  CoreTabBarViewController.swift
//  WeatherOrNot
//
//  Created by Remigio, Kevin (Contractor) on 6/14/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class CoreTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellow
        
        let navBar = CoreNavViewController()
        let firstVC = ViewController()
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        firstVC.title = "Wear are We"
        firstVC.view.backgroundColor = UIColor.blue
        navBar.viewControllers = [firstVC]
        
        
        let secondVC = SecondViewController()
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        secondVC.view.backgroundColor = UIColor.cyan
        
        let thirdVC = WeatherPageViewController()
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        thirdVC.view.backgroundColor = UIColor.yellow
        
        let vcs = [ firstVC, secondVC, thirdVC ]
        viewControllers = vcs
        
//        firstVC.aWeather = 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
