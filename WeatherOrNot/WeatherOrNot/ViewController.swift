//
//  ViewController.swift
//  WeatherOrNot
//
//  Created by Remigio, Kevin (Contractor) on 6/14/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView! = nil
    var containerView: UIView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let containerFrame = CGRect(x: 0, y: 44, width: view.frame.width, height: view.frame.height / 2)
        containerView = UIView(frame: containerFrame)
        containerView.backgroundColor = UIColor.gray
        containerView.isUserInteractionEnabled = true
        view.addSubview(containerView)
        
        let scrollFrame = CGRect(x: 0, y: 44, width: containerView.frame.width, height: containerView.frame.height)
        scrollView = UIScrollView(frame: scrollFrame)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 2000, height: 0)
        containerView.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIScrollViewDelegate {


}
