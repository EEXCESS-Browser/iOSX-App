//
//  ViewController.swift
//  Panic
//
//  Created by Peter Stöhr on 17.12.15.
//  Copyright © 2015 Peter Stöhr. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var synthesizer : AVSpeechSynthesizer!
    var lastPanic = -1
    let panicInfo = ["Panic begins in 3, 2, 1, 0",
                     "Don't Panic!",
                     "Please prepare yourself to panic in 3, 2, 1, 0",
                     "Now panic and freak out!",
                     "Abandon all hope",
                     "Chaos, panic and disorder – my work here is done",
                     "I think, we need a moment of cool panic there."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        synthesizer = AVSpeechSynthesizer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func speak(sender: UIButton) {
        
        var index = Int(arc4random_uniform(UInt32(panicInfo.count)))
        while (index == lastPanic)
        {
            index = Int(arc4random_uniform(UInt32(panicInfo.count)))
        }
        let utterance = AVSpeechUtterance(string: panicInfo[index])
        
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
        synthesizer.speakUtterance(utterance)
    }

}

