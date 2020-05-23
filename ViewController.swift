//
//  ViewController.swift
//  SunriseSunset2
//
//  Created by Dhanvi Ganti on 11/23/19.
//  Copyright © 2019 Dhanvi Ganti. All rights reserved.

// https://github.com/ceeK/Solar/blob/master/README.md
/*
 Thank you so much for taking the time to look at my code! It really helps a lot!
 
 The project:
 There is a reigious event every day that is related to the sunrise and sunset timings. The event is that:
        There is a "window" period of 24 minutes which determines when the "best", "better" and "good" times are to do the prayers.
                The first cycle of "best" "better" and "good" begins at sunrise, and ends 3 windows after, or 72 mins later.
                The 2nd cycle begins 12 windows after sunrise, so 12 * 24 mins = 4 hrs 48 mins, and lasts until 18 * 24 mins after sunrise, so 7 hrs 12 mins after sunrise.
                The 3rd cycle begins at sunset, and ends 72 mins later.
            
 */
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
            //the sleep function is because I read online that Swift takes a few seconds to actually get the location data, so I'd hoped this would give it the time, but it hasn't worked.
          //  locManager.startUpdatingLocation()
            
         /*   do {
                sleep(2)
            }
 */
            
        //    currentLocation = locManager.requestLocation()
        
//        let location =  locationManager(locManager, didUpdateLocations: [locManager.location!]) // https://stackoverflow.com/a/26742973
        let window = 1440 //1440 sec = 24 min, window is the length of one "best" or "better" or "good" period
        let eightHrs = 28800 //will only use in some locations due to incompatible type errors
        
        let lat: CLLocationDegrees = 121.8863
        let long: CLLocationDegrees = 37.3382
        /*
        let location = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        */
        let location2D: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)


        var currentDate = Date()
        
        let secondsFromUTC = Double(TimeZone.current.secondsFromGMT()) //GMT and UTC are the same time
        let tz = TimeZone.current
        if tz.isDaylightSavingTime(for: currentDate) {
            currentDate = Date() - secondsFromUTC //subtracting distance from UTC  (in seconds), since we want in correct time zone
        }
        else {
            currentDate = Date() - secondsFromUTC - 3600 //subtracting distance and and 1 more hr from UTC
        }
      //  print(currentDate)
       // print(type(of: lat))
      //  print(type(of: currentDate))
      //  print(type(of: location2D))
        print(currentDate)
        print(location2D)
        let solar = (Solar(for: currentDate,  coordinate: location2D))! //Solar class is another class I'm using, pulled from online. This is the equation used to calculate the sunrise and sunset.

          let sunrise = solar.sunrise! - secondsFromUTC + 480 //technically just secondsFromUTC, since we are converting UTC to local timezone, but this algorithm is off by ~8 mins, so secondsFromUTC + 480 (calculated in seconds)

          let sunset = solar.sunset! - secondsFromUTC - 480 //algorithm is off by ~8 mins, so I added that back (-28,800 - 480, since it's sunset

        
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .none

        dateFormatter.timeStyle = .short

        //sRise - is a String of the date
        let sunriseString = dateFormatter.string(from: sunrise + TimeInterval(eightHrs))
        
        //sSet - String of date
        let sunsetString = dateFormatter.string(from: sunset + TimeInterval(eightHrs))
        
        //mStart - as above, same for rest below
        let mStartString = dateFormatter.string(from: (sunrise + TimeInterval(eightHrs - 2 * window)))  //adding 8 hrs bc the code is set back by 8 for some reason, and subtracting 48 mins since that's when to start

        //mBestTime2
        let mBestString = dateFormatter.string(from: (sunrise + TimeInterval(eightHrs + 2 * window))) //best time slot, from Start to Best
        
        //mBetter
        let mBetterString = dateFormatter.string(from: sunrise + TimeInterval(eightHrs + 4 * window))
        
        //mGood
        let mGoodString = dateFormatter.string(from: sunrise + TimeInterval(eightHrs + 6 * window))
        
        //aBest Part 1 - gets start time without AM/PM
        let aBestP1 = (dateFormatter.string(from: sunrise + TimeInterval(eightHrs + 12 * window))).dropLast(3)
        
        //aBest Part 2 - gets end time without AM/PM
        let aBestP2 = (dateFormatter.string(from: sunrise + TimeInterval(eightHrs + 18 * window))).dropLast(3)
        
        //aBest - has been clarified as String
        let aBestString: String  =  aBestP1 + "-" +  aBestP2 //gives a range, from 12th unit to 18th.
        
        //aBetter Part 1 - gets start time without AM/PM
        let aBetterP1 = (dateFormatter.string(from: sunrise + TimeInterval(eightHrs + 7 * window))).dropLast(3)
        
        //aBetter Part 2 - gets end time without AM/PM. Equal to aBestP1, since aBetter ends when aBest starts
        let aBetterP2 = aBestP1
        
        //aBetter - has been clarified as String
        let aBetterString: String = aBetterP1 + "-" + aBetterP2
        
        //eStart
        let eStartString = dateFormatter.string(from: sunset + TimeInterval(eightHrs - 1 * window))
        
        //eBest
        let eBestString = dateFormatter.string(from: sunset + TimeInterval(eightHrs + 3 * window))
        
        //eBetter
        let eBetterString = dateFormatter.string(from: sunset + TimeInterval(eightHrs + 4 * window))
        
        //eGood
        let eGoodString = dateFormatter.string(from: sunset + TimeInterval(eightHrs + 6 * window))
        
        sRise.text = sunriseString
        sRise.textColor = UIColor.blue
        sSet.text = sunsetString
        sSet.textColor = UIColor.blue
        
        label1.text = mStartString //label1 is mStart, idk how to change name
        label1.textColor = UIColor.red
        mBestTime2.text = mBestString
        mBestTime2.textColor = UIColor.blue
        mBetter.text = mBetterString
        mGood.text = mGoodString
        mGood.textColor = UIColor.darkGray
        
        aBest.text = aBestString
        aBest.textColor = UIColor.blue
        aBetter.text = aBetterString
        
        eStart.text = eStartString
        eStart.textColor = UIColor.red
        eBest.text = eBestString
        eBest.textColor = UIColor.blue
        eBetter.text = eBetterString
        eGood.text = eGoodString
        eGood.textColor = UIColor.darkGray
        }

    @IBOutlet weak var sRise: UILabel!
    @IBOutlet weak var sSet: UILabel!
    
    @IBOutlet weak var label1: UILabel! //referring to mStart
    @IBOutlet weak var mBestTime2: UILabel!
    
    @IBOutlet weak var mBetter: UILabel!
    @IBOutlet weak var mGood: UILabel!
    
    @IBOutlet weak var aBest: UILabel!
    @IBOutlet weak var aBetter: UILabel!
    
    @IBOutlet weak var eStart: UILabel!
    @IBOutlet weak var eBest: UILabel!
    @IBOutlet weak var eBetter: UILabel!
    @IBOutlet weak var eGood: UILabel!
    
    
}

