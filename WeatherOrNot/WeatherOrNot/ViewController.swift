//
//  ViewController.swift
//  WeatherOrNot
//
//  Created by Remigio, Kevin (Contractor) on 6/14/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit

enum mainTableCellType: String {
    case HorizontalScrollable
    case Long
}

class ViewController: UIViewController {
    
    var scrollView: UIScrollView! = nil
    var containerView: UIView! = nil
    
    var mainScreenTableView:UITableView? = nil
    
    var myWeather: Weather? = nil
    var headerOpacity: CGFloat? = 1.0
    var topTableHeaderView: UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let mainScreenTableViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 44.0)
//        tabViewController.tabBar.frame.size.height
        mainScreenTableView = UITableView(frame: mainScreenTableViewFrame)
        mainScreenTableView?.delegate = self
        mainScreenTableView?.dataSource = self
        
        mainScreenTableView?.register(ScrollableTableViewCell.self, forCellReuseIdentifier: "scrollablecell")

        mainScreenTableView?.register(LongTableViewCell.self, forCellReuseIdentifier: "longcell")
        mainScreenTableView!.tag = 1234
        view.addSubview(mainScreenTableView!)
        
        /*

        
        let myTemp = Temperature(kelvin: 291.483)
        myWeather = Weather(wthr: WeatherType.Texas, temp: myTemp, humid: "43%")
        
        print(myWeather?.temperature.celsius ?? "")
        print(myWeather?.temperature.fahrenheit ?? "")
        
        let aString = "hello"
        
        let a = aString.removeTrailingZeros(number: "hello")
        print(a)

         */
    }



}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //# OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //CELLS!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "scrollablecell", for: indexPath) as? ScrollableTableViewCell {
                
                cell.setCollectionViewDataSourceDelegate(dataSource: self as UICollectionViewDataSource, dataDelegate: self as UICollectionViewDelegate, forRow: indexPath.row)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "longcell", for: indexPath) as? LongTableViewCell {
                return cell
            }
        default:
            UITableViewCell()
        }

        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    //CELL HEIGHT!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 160.0
        case 1:
            return 350.0
        default:
            return 160.0
        }
//        return 160
    }
    //HMM SECTIONS!
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (2 / 3) * view.frame.height
    }
    //HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let topViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100.0)
        topTableHeaderView = UIView(frame: topViewFrame)
        topTableHeaderView?.backgroundColor = UIColor.yellow.withAlphaComponent(headerOpacity!)
        return topTableHeaderView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("do something")

    }
    func getOpacityFade(y: CGFloat, x: CGFloat) {
        let opacity = ( y / x )
        
        headerOpacity = opacity
    }
    
    //footer!!
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let aViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.0)
        let footerView = UIView(frame: aViewFrame)
        footerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        return footerView
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //dataArray[collectionView.tag].count
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.orange
        
        return cell
    }
}
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tag 1234 is main top header view
        if scrollView.tag == 1234 {
            let sectionHeaderHeight:CGFloat = (5 / 6) * view.frame.height - 200
            //scroll down and up
            if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
                
                getOpacityFade(y: scrollView.contentOffset.y, x: sectionHeaderHeight)
                topTableHeaderView?.backgroundColor = UIColor.yellow.withAlphaComponent(headerOpacity!)
                
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
                
            } else if scrollView.contentOffset.y >= sectionHeaderHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
            }
        } else {
        
            //different scrollview is scrolling
            print("do other things")
        }

    }
}
