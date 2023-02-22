//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
  
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleEggTimer: UILabel!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var seconds = 0
    var stopTime = 3600
    var timer = Timer()
    
    var eggState = ""
    
    var player: AVAudioPlayer?


    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let title = sender.currentTitle!
    
        eggState = title
        
        titleEggTimer.text = "How do you like your eggs?"
        progressView.progress = 0
        stopTime = eggTimes[title]!
        runTimer()
    }
    
    func runTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        progressView.progress = Float(Double(seconds)/Double(stopTime))
        
        if seconds == stopTime {
            eggIsDone()
        }
    }
    
    
    func eggIsDone() {
        timer.invalidate()
        seconds = 0
        titleEggTimer.text = "Egg is done (\(eggState))"
        
        playSound(sondName: "alarm_sound")
        
    }
    
    func playSound(sondName: String) {
        guard let url = Bundle.main.url(forResource: sondName, withExtension: "mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
