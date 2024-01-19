//
//  AudioPlayer.swift
//  Restart
//
//  Created by Nickelfox on 05/01/24.
//

import Foundation
import AVFAudio

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type:String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
           audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Couldnot play the sound file")
        }
    }
    
}
