//
//  Timer.swift
//  Speedy
//
//  Created by Edward Chiou on 3/3/15.
//  Copyright (c) 2015 Krishna Kolli. All rights reserved.
//

import Foundation

class Timer{
    var timer = NSTimer()
    var handler: (Int) -> ()
    var duration: Int
    var elapsedTime = 0
    
    let TIME_DEBUG = false
    
    init(duration: Int, handler: (Int) -> ()){
        self.duration = duration
        self.handler = handler
    }
    
    deinit {
        timer.invalidate()
    }
    
    func start(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("tick"), userInfo: nil, repeats: true)
    }
    
    func addTime(seconds: Int){
        elapsedTime -= seconds
    }
    
    func tick(){
        elapsedTime++
        handler(elapsedTime)
        
        if elapsedTime == duration{
            stop()
        }
    }
    
    func stop() {
        timer.invalidate()
    }
    
    /*
    This takes something like 0 and turns it into 00:00
    and if it takes something like 60 -> 01:00
    if it takes 170 -> 02:10
    */
    func convertIntToTime(secondsPassed: Int) -> String {
        var count = duration - secondsPassed
        
        let seconds_per_minute = 60
        var minutes = count / seconds_per_minute
        var seconds = count % seconds_per_minute
        
        var minute_display = "", second_display = ""
        
        if (minutes >= 10) {
            minute_display = String(minutes)
        } else {
            minute_display = "0" + String(minutes)
        }
        
        if (seconds >= 10) {
            second_display = String(seconds)
        } else {
            second_display = "0" + String(seconds)
        }
        
        if (TIME_DEBUG) {
            println("seconds: \(seconds)" + " second display : " + second_display)
            println("displaying: " + minute_display + ":" + second_display)
        }
        return minute_display + ":" + second_display
    }
}