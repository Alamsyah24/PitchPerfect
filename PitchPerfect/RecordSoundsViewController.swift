//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Mochammad Alamsyah on 05/01/18.
//  Copyright © 2018 malamsyah.id. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var startRecordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordButton.isEnabled = false
    }
    
    // MARK: - recording state helper function
    
    func setRecordingState(startButton: Bool, stopButton: Bool, message: String){
        startRecordButton.isEnabled = startButton
        stopRecordButton.isEnabled = stopButton
        recordLabel.text = message
    }
    
    // MARK: - Record Audio
    
    @IBAction func recordAudio(_ sender: UIButton) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        setRecordingState(startButton: false, stopButton: true, message: "Recording in Progress")
    }
    
    // MARK: - Stop Recording Audio
    
    @IBAction func stopRecording(_ sender: UIButton) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        setRecordingState(startButton: true, stopButton: false, message: "Tap To Record")
    }
    
    // MARK: - Audio Recorder Delegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Audio Recording Success")
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else  {
            print("Audio Recording Failed")
        }
    }
    
    //MARK: - Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

