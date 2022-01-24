//
//  ViewController.swift
//  WkitSwoomi
//
//  Created by 권성은 on 2021/11/30.
//

import UIKit
import WebKit
import Speech
import AVFoundation

class ViewController: UIViewController, SFSpeechRecognizerDelegate{
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var webView: WKWebView!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var speechInput = ""
    var coolTimeListOutput: [String: AnyObject] = [:]
//    var coolTimeListOutput: [coolTimeList] = []
    var coolTimeListInput: [String] = []
    
//    struct coolTimeList {
//        let type: String
//        let payload: String
//    }
    
    enum SpeechStatus {
        case ready
        case recognizing
        case unavailable
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self

        _ = Timer.scheduledTimer(withTimeInterval: 50, repeats: true, block: { (timer) in
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
            @unknown default:
                    fatalError()
        }

//        initWebview_then_callFromJs()
        loadUrl()
        requestMicrophonePermission()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("viewDidAppear Call")
        
        checkNetworkConnect()
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
                
//                self.myTextView.text = result?.bestTranscription.formattedString
//                print(self.myTextView.text!)
                self.speechInput = (result?.bestTranscription.formattedString)!
                print(self.speechInput)
                self.coolTimeListInput = ["voiceRecognition", self.speechInput as String]
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(self.coolTimeListInput)
                    if let jsonString = String(data: data, encoding: .utf8) {
                      print(jsonString)
                    }
                } catch {
                    print(error)
                }
                
                self.webView.evaluateJavaScript("system('\(self.coolTimeListInput)');", completionHandler: { result, error in
                    if let anError = error {
                            print("Error \(anError.localizedDescription)")
                        }
                                        
                        print("Result \(result ?? "")")
                })
                
                isFinal = (result?.isFinal)!
            }
            
//            if let timer = self.detectionTimer, timer.isValid {
//                        if isFinal {
//                            self.myTextView.text = ""
//                            self.textViewDidChange(self.myTextView)
//                            self.detectionTimer?.invalidate()
//                        }
//                    } else {
//                        self.detectionTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
//                            self.handleSend()
//                            isFinal = true
//                            timer.invalidate()
//                        })
//                    }
            
            
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
        
//        myTextView.text = "Say something, I'm listening!"
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

extension ViewController:  WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
//    func initWebview_then_callFromJs(){
//        ///Javascript Call Function Controller
//        let contentController = WKUserContentController()
//        let config = WKWebViewConfiguration()
//
//        contentController.add(self, name: "system")
//        config.userContentController = contentController
//    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadUrl(){
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        contentController.add(self, name: "callbackHandler")
        config.userContentController = contentController
        
        ///WKWebview 셋팅
//        let url = URL(string: "https://test.swoomi.me/share/kfo")
        let url = URL(string: "https://test.swoomi.me/")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view.addSubview(webView)
    }
    
    func checkNetworkConnect(){
        ///Alert를 사용한 Network의 Check는 viewDidAppear에서 수행
        if Reachability.isConnectedToNetwork(){
            print("Network Connect")
        } else{
            print("Network Not Connect")
            
            let networkCheckAlert = UIAlertController(title: "Network ERROR", message: "앱을 종료합니다.", preferredStyle: UIAlertController.Style.alert)
            
            networkCheckAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                print("App exit")
                
                exit(0)
            }))
            
            self.present(networkCheckAlert, animated: true, completion: nil)
        }
    }
    
    ///WKScriptMessageHandler에서 제공하는 함수이용하여 데이터 수신
    @available(iOS 8.0, *)
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("userContent")
        if message.name == "callbackHandler" {
            print("받앗음")
            print(message.body)
            guard let receiveData = message.body as? [String: AnyObject] else { return }
            //type이 어떤거로 들어오는지 처리해야함
            let coolRemain = receiveData["payload"] as? String
            print(coolRemain!)
//            let synthesizer = AVSpeechSynthesizer()
//            let utterance = AVSpeechUtterance(string: coolRemain!)
//            utterance.rate = 0.2
//            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
//            synthesizer.speak(utterance)
//                do {
//                    let data = try? JSONDecoder().decode(coolTimeListOutput.self, from: receiveData)
//                    let synthesizer = AVSpeechSynthesizer()
//                    let utterance = AVSpeechUtterance(string: data.payload)
//                    utterance.rate = 0.2
//                    utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
//                    synthesizer.speak(utterance)
//                } catch let error {
//                    print("Error json parsing \(error)")
//                    }
            } else {
                print("깡통")
//                let synthesizer = AVSpeechSynthesizer()
//                let utterance = AVSpeechUtterance(string: "없음")
//                utterance.rate = 0.2
//                utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
//                synthesizer.speak(utterance)
            }
    }
    
    func requestMicrophonePermission(){
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Mic: 권한 허용")
            } else {
                print("Mic: 권한 거부")
            }
        })
    }
}
