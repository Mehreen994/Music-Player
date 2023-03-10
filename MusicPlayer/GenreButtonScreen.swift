//
//  GenreButtonScreen.swift
//  MusicPlayer
//
//  Created by Mehreen Kanwal on 30.01.23.
//

import UIKit
import AVFoundation

class GenreButtonScreen: UIViewController {
    
    var player : AVAudioPlayer?
    var position :Int = 0
    var songs = [song]()
    
    func addSongsToArray (){
        songs.append(song(name: "Rnado", trackname: "song1"))
        songs.append(song(name: "Viva La Vida", trackname: "song2"))
        songs.append(song(name: "Havaana", trackname: "song3"))
        
    }
    
    
//    All the outlets
    
    @IBOutlet var containerView : UIView!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var halfButtonview : UIView!
    @IBOutlet var playButton : UIButton!
    @IBOutlet var stopButton : UIButton!
    @IBOutlet var nextButton : UIButton!
    @IBOutlet var knobView : UIView!
    @IBOutlet var slider : UISlider!
    @IBOutlet var musicNameLabel : UILabel!
    
    
//    MP3Player
    public func mp3player () {
         let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackname, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
         player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                return
            }
    
        }
        catch{
            print("error occurred")
        }
    }
    
   @objc func buttonDidTappedForStop(){
        if player?.isPlaying == true {
            player?.stop()
        }
        else{
            return
        }
    }
    @objc func buttonDidTappedForPlay(){
         if player?.isPlaying == false {
             player?.play()
         }
         else{
             return
         }
     }
    @objc func buttonDidTappedForNext(){
        if position < (songs.count-1){
            position = position+1
            mp3player()
            player?.play()
            self.musicNameLabel.text = songs[position].name
            didSlideSlider()
        }
        else {
            position = 0
            mp3player()
            player?.play()
            self.musicNameLabel.text = songs[position].name
            didSlideSlider()
        }
     }
    @objc func didSlideSlider(){
        let value = slider.value
        player?.volume = value
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.halfButtonview.layer.cornerRadius = 20.0
        self.knobView.layer.cornerRadius = 5.0
        makingButtonsCircular(sender: playButton)
        makingButtonsCircular(sender: stopButton)
        makingButtonsCircular(sender: nextButton)
        addSongsToArray()
        mp3player()
        self.stopButton.addTarget(self, action: #selector(buttonDidTappedForStop), for: .touchUpInside)
        self.playButton.addTarget(self, action: #selector(buttonDidTappedForPlay), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(buttonDidTappedForNext), for: .touchUpInside)
        self.slider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        self.musicNameLabel.text = songs[position].name
       
    }
    
    func makingButtonsCircular (sender:UIButton) {
        sender.layer.cornerRadius = 0.5 * sender.bounds.size.width
        sender.clipsToBounds = true
    }
    
}


struct song {
    let name : String
    let trackname : String
}
