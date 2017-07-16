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

class ViewController: UIViewController, UITextFieldDelegate {
    
    var headerView: MainHeaderView? = nil
    
    let maxHeaderHeight: CGFloat = 380
    let minHeaderHeight: CGFloat = 70
    var previousScrollOffset: CGFloat = 0.0
    
    func resetAPICallCount() {
        APICallCountPerMinute = 4
        timer?.invalidate()
        timer = nil
    }
    func APICallCountFilter() {
        APICallCountPerMinute -= 1
        if APICallCountPerMinute <= 0 {
            let alertController = UIAlertController(title: "Limit 4 calls per minute", message: "Chill for a minute", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                // ...
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                // ...
            }
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 20, target: self,  selector: (#selector(ViewController.resetAPICallCount)), userInfo: nil, repeats: false)

            }
            //print("time left: \(timer?.timeInterval)")
        }
    }
    func fetchForecast() -> Void  {
        let net: NetworkHandler = NetworkHandler(zip: (zipTextField?.text!)!)
        net.requestForecast(completion: { (ready) -> Void in

            self.aForecast = ready
            self.goButton?.setTitleColor(UIColor.blue, for: .normal)
            // When download completes,control flow goes here.
//            if ready != nil {
//                // download success
//                self.aForecast = ready
//                self.goButton?.setTitleColor(UIColor.blue, for: .normal)
//            } else {
//                // download fail
//                print("oh word, no new shit")
//            }
        })

    }
    func fetchNewWeatherFromZip() -> Void {
        zipTextField?.resignFirstResponder()
        fetchForecast()
        
        goButton?.setTitleColor(UIColor.gray, for: .normal)
        APICallCountFilter()
        if zipTextField?.text != nil && zipTextField?.text != "" && APICallCountPerMinute > 0{
            print("Tapped search for zip: \(zipTextField?.text! ?? "nil!")")
            print("Make the request")
            let net: NetworkHandler = NetworkHandler(zip: (zipTextField?.text!)!)
            net.request(completion: { (available) -> Void in
                
                self.aWeather = available
                self.goButton?.setTitleColor(UIColor.blue, for: .normal)
                // When download completes,control flow goes here.
//                if available != nil {
//                    // download success
//                    self.aWeather = available
//                    self.goButton?.setTitleColor(UIColor.blue, for: .normal)
//                } else {
//                    // download fail
//                    print("oh word, no new shit")
//                }
            })
            
        }
    }
    
    var highestSoFar:Float = 0.0
    
    var aWeather: Weather? {
        didSet {
            mainScreenTableView?.reloadData()
            if headerView != nil {
                headerView?.setLabelTexts(weather: aWeather)
            }
        }
    }
    var aForecast: Forecast? {
        didSet {
            mainScreenTableView?.reloadData()
        }
    }
    //*******pull down refresh attributes*******//
    var timer: Timer? = nil
    lazy var reloadControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor(red: 137/255, green: 181/255, blue: 218/255, alpha: 1.0)
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)

        return refreshControl
    }()
    
    var pullRefreshTimeStamp:String? {
        
        return "Yo the time is 10:17!"
    }
    
    let pullDownfontAttributes = [
        NSForegroundColorAttributeName: UIColor.black,
        NSFontAttributeName:UIFont(name: "PingFangTC-Light", size: 17.0),
        ]
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        mainScreenTableView?.reloadData()
        
        reloadControl.endRefreshing()
    }
    //*******pull down refresh attributes*******//
    
    var APICallCountPerMinute: Int = 4
    
    let goldenRatio: CGFloat = 7 / 9
//    var scrollView: UIScrollView! = nil
    var containerView: UIView! = nil
    
    var mainScreenTableView:UITableView? = nil
    
    var myWeather: Weather? = nil
    var headerOpacity: CGFloat? = 1.0
    var topTableHeaderView: MainHeaderView? = nil

    var zipTextField: ShakingTextField? = nil
    var goButton: UIButton? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let zipTextFrame = CGRect(x: 8, y: 28, width: view.frame.width - 55, height: 32)
        zipTextField = ShakingTextField(frame: zipTextFrame)
        zipTextField?.placeholder = "Zip Code"
        zipTextField?.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        zipTextField?.borderStyle = .roundedRect
        zipTextField?.delegate = self as? UITextFieldDelegate

        
        view.addSubview(zipTextField!)
        
        let goButtonFrame = CGRect(x: view.frame.width - 40, y: 28, width: 24, height: 32)
        goButton = UIButton(frame: goButtonFrame)
        goButton?.setTitle("Go", for: .normal)
        goButton?.setTitleColor(UIColor.blue, for: .normal)
        goButton?.addTarget(self, action: (#selector(ViewController.fetchNewWeatherFromZip)), for: .touchUpInside)
        view.addSubview(goButton!)
        
        
        let mainScreenTableViewFrame = CGRect(x: 0, y: 450, width: view.frame.width, height: view.frame.height - 450)
        mainScreenTableView = UITableView(frame: mainScreenTableViewFrame)
        mainScreenTableView?.delegate = self as? UITableViewDelegate
        mainScreenTableView?.dataSource = self as? UITableViewDataSource
        
        mainScreenTableView?.register(ScrollableTableViewCell.self, forCellReuseIdentifier: "scrollablecell")

        mainScreenTableView?.register(LongTableViewCell.self, forCellReuseIdentifier: "longcell")
        mainScreenTableView!.tag = 1234
        
        reloadControl.attributedTitle = NSAttributedString(string: pullRefreshTimeStamp!, attributes: pullDownfontAttributes )
        mainScreenTableView?.addSubview(reloadControl)
        
        
        view.addSubview(mainScreenTableView!)
        
        setUpViews()
    

    }
    func setUpViews() -> Void{
        let headerFrame = CGRect(x: 0, y: 70, width: view.frame.width, height: 380)
        headerView = MainHeaderView(frame: headerFrame)
        headerView?.backgroundColor = AppUtility.sharedInstance.getRandomColor()
        
        view.addSubview(headerView!)
        
    }
    func getWeather() {
        let weatherRouter: Router = Router.Weather
        NetworkHandler.sharedInstance.request(request: weatherRouter, success: { [unowned self] (jsonObject, httpResponse) -> Void in
            if let json = jsonObject {
                let weatherObj = Weather(json:json)
                self.aWeather = weatherObj
            }
            
            })
        { (errorString, httpResponse) -> Void in
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        fetchNewWeatherFromZip()
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        zipTextField?.shake()
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        zipTextField?.stopShake()
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
                cell.backgroundColor = AppUtility.sharedInstance.getRandomColor()
                return cell
            }
        default:
            print("Woops idk")
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
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return goldenRatio * view.frame.height
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return goldenRatio * view.frame.height
    }
    //HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let topViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: goldenRatio * view.frame.height)
            topTableHeaderView = MainHeaderView(frame: topViewFrame)
            if aWeather != nil {
                topTableHeaderView?.setLabelTexts(weather: self.aWeather)
            }
        
            
            return topTableHeaderView
    }
    */
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if canAnimateHeader(scrollView) {
            
            let absoluteTop: CGFloat = 0
            let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
            
            let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
            
            let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
            let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
            
            var newHeight = headerView?.frame.height
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, (headerView?.frame.height)! - abs(scrollDiff))
                print("Down")
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, (headerView?.frame.height)! + abs(scrollDiff))
                print("Up")
            }
            
            if newHeight != headerView?.frame.height {
                
                headerView?.frame.size.height = newHeight!
//                headerView?.temparatureLabel?.frame.size.height = headerView!.temparatureLabel!.frame.size.height + newHeight!
                headerView?.backgroundColor = AppUtility.sharedInstance.getRandomColor().withAlphaComponent(self.headerOpacity!)
                
                mainScreenTableView?.frame.origin.y = newHeight! + minHeaderHeight

                mainScreenTableView?.frame.size.height = view.frame.size.height - newHeight!
                

                print(newHeight!)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
            
        }
        
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + headerView!.frame.height - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //dataArray[collectionView.tag].count
        if aForecast != nil {
            if aForecast!.count != nil && aForecast!.count! > 0 {
                return aForecast!.count!
            }
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastcell", for: indexPath as IndexPath) as? ForecastCollectionViewCell
        if aForecast != nil {
            cell?.weatherLabel?.text = "\(aForecast!.forecastArray[indexPath.row].weatherArray.first!.main!)"
            
            let unixTimestamp = aForecast!.forecastArray[indexPath.row].dt!
            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "E, h a" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            cell?.timeLabel?.text = "\(strDate)"
            
            let temp = Temperature(kelvin: aForecast!.forecastArray[indexPath.row].main!.temp!)
            cell?.tempLabel?.text = "\(temp.fahrenheit!)°"
            
            let highTemp = Temperature(kelvin: aForecast!.forecastArray[indexPath.row].main!.tempMax!)
            let lowTemp = Temperature(kelvin: aForecast!.forecastArray[indexPath.row].main!.tempMin!)
            cell?.highLowTempLabel?.text = "\(highTemp.fahrenheit!)°/\(lowTemp.fahrenheit!)°"
            
            let id = aForecast!.forecastArray[indexPath.row].weatherArray.first!.id!
            let iconString = Icons().getIconWith(code: id)
            cell?.weatherImage!.image = UIImage(named: iconString)
            
        }
        
        let modRow = indexPath.row % 4
        switch modRow {
        case 0:
            cell?.backgroundColor = UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0)
        case 1:
            cell?.backgroundColor = UIColor(red: 242/255, green: 226/255, blue: 151/255, alpha: 1.0)
        case 2:
            cell?.backgroundColor = UIColor(red: 137/255, green: 181/255, blue: 218/255, alpha: 1.0)
        case 3:
            cell?.backgroundColor = UIColor(red: 97/255, green: 213/255, blue: 212/255, alpha: 1.0)
        default:
            print("How did you get here")
        }
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 160.0)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tag 1234 is main top header view
        print(scrollView.contentInset.top)
        
        if scrollView.tag == 1234 {
            let sectionHeaderHeight:CGFloat = goldenRatio * view.frame.height - 60
            //scroll down and up
            if scrollView.contentOffset.y < sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
                
                getOpacityFade(y: scrollView.contentOffset.y, x: sectionHeaderHeight)
                topTableHeaderView?.backgroundColor = AppUtility.sharedInstance.getRandomColor().withAlphaComponent(self.headerOpacity!)
                //UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0).withAlphaComponent(self.headerOpacity!)
                topTableHeaderView?.weatherImage?.alpha = 1 - self.headerOpacity!
                
                print("scroll view content offset\(-scrollView.contentOffset.y)")
                scrollView.contentInset.top = -scrollView.contentOffset.y
                
                
            } else if scrollView.contentOffset.y > sectionHeaderHeight {
                
                print("section header height \(-sectionHeaderHeight)")
                scrollView.contentInset.top = -sectionHeaderHeight
                
                topTableHeaderView?.backgroundColor = AppUtility.sharedInstance.getRandomColor().withAlphaComponent(self.headerOpacity!)
//                self.topTableHeaderView?.backgroundColor = UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0).withAlphaComponent(1.0)
            }
            
        } else {
        
            //different scrollview is scrolling
            print("do other things")
        }
        
    }
     */
}
