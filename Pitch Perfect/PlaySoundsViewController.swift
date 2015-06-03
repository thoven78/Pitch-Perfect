//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stevenson Michel on 5/31/15.
//  Copyright (c) 2015 Stevenson Michel. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    
    var recievedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
        navigationItem.title = "Audio Effects"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playChickMunkAudio(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        stopAllAudio() // stop all audio before play
        playAudioWithVariablePitch(-1000)
    }
    
    func stopAllAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
    
    func playWithRate(rate: Float) {
        stopAllAudio()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    // This function is responsible to play audio 
    // files with different pitch
    func playAudioWithVariablePitch(pitch: Float) {
        
        stopAllAudio() // stop all audio
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()

    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        stopAllAudio()
        playWithRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        stopAllAudio()
       playWithRate(1.50)
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAllAudio()
    }

}
