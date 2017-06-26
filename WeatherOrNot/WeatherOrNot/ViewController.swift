//
//  ViewController.swift
//  WeatherOrNot
//
//  Created by Remigio, Kevin (Contractor) on 6/14/17.
//  Copyright © 2017 Remigio, Kevin (Contractor). All rights reserved.
//

import UIKit
import Darwin

enum mainTableCellType: String {
    case HorizontalScrollable
    case Long
}

class ViewController: UIViewController {
    
    //*******pull down refresh attributes*******//
    var timer = Timer()
    lazy var reloadControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        return refreshControl
    }()
    
    var pullRefreshTimeStamp:String?{
        
        return "Yo the time is 10:17!"
    }
    
    let pullDownfontAttributes = [
        NSForegroundColorAttributeName: UIColor.black,
        NSFontAttributeName:UIFont(name: "PingFangTC-Light", size: 17.0),
        ]
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        mainScreenTableView?.reloadData()
        runTimer()
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,   selector: (#selector(ViewController.endRefresh)), userInfo: nil, repeats: false)
    }
    func endRefresh() {
        reloadControl.endRefreshing()
    }
    //*******pull down refresh attributes*******//
    
    let goldenRatio: CGFloat = 7 / 9
    var scrollView: UIScrollView! = nil
    var containerView: UIView! = nil
    
    var mainScreenTableView:UITableView? = nil
    
    var myWeather: Weather? = nil
    var headerOpacity: CGFloat? = 1.0
    var topTableHeaderView: MainHeaderView? = nil

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
        
        reloadControl.attributedTitle = NSAttributedString(string: pullRefreshTimeStamp!, attributes: pullDownfontAttributes)
        mainScreenTableView?.addSubview(reloadControl)
        
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
        return goldenRatio * view.frame.height
    }
    //HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let topViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: goldenRatio * view.frame.height)
        topTableHeaderView = MainHeaderView(frame: topViewFrame)
        topTableHeaderView?.backgroundColor = UIColor.yellow.withAlphaComponent(0.0)
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //dataArray[collectionView.tag].count
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        let modRow = indexPath.row % 4
        switch modRow {
        case 0:
            cell.backgroundColor = UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0)
        case 1:
            cell.backgroundColor = UIColor(red: 242/255, green: 226/255, blue: 151/255, alpha: 1.0)
        case 2:
            cell.backgroundColor = UIColor(red: 137/255, green: 181/255, blue: 218/255, alpha: 1.0)
        case 3:
            cell.backgroundColor = UIColor(red: 97/255, green: 213/255, blue: 212/255, alpha: 1.0)
        default:
            print("How did you get here")
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 160.0)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tag 1234 is main top header view
        if scrollView.tag == 1234 {
            let sectionHeaderHeight:CGFloat = goldenRatio * view.frame.height - 60
            //scroll down and up
            if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
                
                getOpacityFade(y: scrollView.contentOffset.y, x: sectionHeaderHeight)
                
                UIView.animate(withDuration: 0.2, delay: 0.1, options: [],
                               animations: {
                                self.topTableHeaderView?.backgroundColor = UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0).withAlphaComponent(self.headerOpacity!)
                                self.topTableHeaderView?.weatherImage?.alpha = 1 - self.headerOpacity!
                }, 
                               completion: nil
                )
                
                
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
                
            } else if scrollView.contentOffset.y >= sectionHeaderHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
                self.topTableHeaderView?.backgroundColor = UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0).withAlphaComponent(1.0)
            }
        } else {
        
            //different scrollview is scrolling
            print("do other things")
        }

    }
}
