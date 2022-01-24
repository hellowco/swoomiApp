//
//  ViewController.swift
//  STT
//
//  Created by 권성은 on 2021/12/07.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    @IBOutlet weak var button: UIButton!
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBAction func speechToText(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            button.isEnabled = false
            button.setTitle("Start Recording", for: .normal)

        } else {
            startRecording()
            button.setTitle("Stop Recording", for: .normal)
        }
    }
    @IBOutlet weak var myTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self

        let timer = Timer.scheduledTimer(withTimeInterval: 50, repeats: true, block: { (timer) in
            print("timer")
//            timer.invalidate()
            self.speechToText((Any).self)
        })
//                speechToText((Any).self)
        switch SFSpeechRecognizer.authorizationStatus() {
                case .notDetermined:
                    askSpeechPermission()
                    print("not determined")
                case .authorized:
                    print("authorized")
                case .denied, .restricted:
                    print("denied or restricted")
                    self.showAlert(title: "SpeechNote", message: "There has been an audio engine error.", handler: nil)
            }

    }
    override func viewDidAppear(_ animated: Bool) {
//        speechToText((Any).self)
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
           DispatchQueue.main.async { [unowned self] in
               let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
               self.present(alertController, animated: true, completion: nil)
           }
       }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        print(audioSession.isInputAvailable)
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
            self.showAlert(title: "SpeechNote", message: "There has been an audio engine error.", handler: nil)
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.myTextView.text = result?.bestTranscription.formattedString
                print(self.myTextView.text!)
                isFinal = (result?.isFinal)!
            } else {
//                self.showAlert(title: "SpeechNote", message: "There has been an audio engine error.", handler: nil)
            }
//            self.showAlert(title: "SpeechNote", message: "There has been an audio engine error.", handler: nil)
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.button.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
            self.showAlert(title: "SpeechNote", message: "There has been an audio engine error.", handler: nil)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
                    self.showAlert(title: "SpeechNote", message: "Speech recognition is not supported for your current locale.", handler: nil)
                    return
                }
                if !myRecognizer.isAvailable {
                    self.showAlert(title: "SpeechNote", message: "Speech recognition is not currently available. Check back at a later time.", handler: nil)
                    
                    return
                }
        
        myTextView.text = "Say something, I'm listening!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            button.isEnabled = true
        } else {
            button.isEnabled = false
        }
    }
    
    func askSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { status in
            OperationQueue.main.addOperation {
                
            }
        }
    }
    
}

