//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Mochammad Alamsyah on 08/01/18.
//  Copyright © 2018 malamsyah.id. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: - Button content mode
    
    func setButtonContentMode(mode:UIViewContentMode) {
        snailButton.imageView?.contentMode = mode
        rabbitButton.imageView?.contentMode = mode
        chipmunkButton.imageView?.contentMode = mode
        vaderButton.imageView?.contentMode = mode
        reverbButton.imageView?.contentMode = mode
        echoButton.imageView?.contentMode = mode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setButtonContentMode(mode:UIViewContentMode.scaleAspectFit)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    // MARK: - Plays Sound Buttons
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Type : " , ButtonType(rawValue: sender.tag)!)
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // MARK: - Stop current audio
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

}


