//
//  ViewController.swift
//  PlaylistApp
//
//  Created by James Flynn on 10/18/24.
//


    //    init(contentsOf: URL)
    //    Creates a player to play audio from a file.
    //    init(contentsOf: URL, fileTypeHint: String?)
    //    Creates a player to play audio from a file of a particular type.
    //    init(data: Data)
    //    Creates a player to play in-memory audio data.
    //    init(data: Data, fileTypeHint: String?)
    //    Creates a player to play in-memory audio data of a particular type.
    
    //    Controlling playback
    
    //    func prepareToPlay() -> Bool
    //    Prepares the player for audio playback.
    //    func play() -> Bool
    //    Plays audio asynchronously.
    //    func play(atTime: TimeInterval) -> Bool
    //    Plays audio asynchronously, starting at a specified point in the audio output device’s timeline.
    //    func pause()
    //    Pauses audio playback.
    //    func stop()
    //    Stops playback and undoes the setup the system requires for playback.
    //    var isPlaying: Bool
    //    A Boolean value that indicates whether the player is currently playing audio.
    
    
    
import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var song: UILabel!
    
    //    var queuePlayer: AVQueuePlayer?
    var isPlaying = false
    var index: Int = 0
    var arr: [AVAudioPlayer] = []
    var covers: [UIImage?] = []
    var artist: [String] = []
    var songtitle: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        artist = [
            "Radiohead",
            "Hoobastank",
            "Goo Goo Dolls",
            "Pink Floyd",
            "Incubus",
            "Foo Fighters",
            "Stone Temple Pilots",
            "Jeff Buckley",
            "Guns N' Roses",
            "Red Hot Chili Peppers"
        ]
        
        songtitle = [
            "Creep",
            "The Reason",
            "Iris",
            "Wish You Were Here",
            "Drive",
            "Everlong",
            "Interstate Love Song",
            "Last Goodbye",
            "November Rain",
            "Under the Bridge"
        ]
        
        
        
        
        covers = [
            UIImage(named: "creep-ep"),
            UIImage(named: "best of hoobastank"),
            UIImage(named: "dizzy up the girl"),
            UIImage(named: "WYWH"),
            UIImage(named: "make yourself"),
            UIImage(named: "colour and shape"),
            UIImage(named: "purple"),
            UIImage(named: "grace"),
            UIImage(named: "use your illusion"),
            UIImage(named: "blood sugar sex magik")
        ]
        
        let songs = [
            Bundle.main.url(forResource: "Radiohead - Creep", withExtension: "mp3"),
            Bundle.main.url(forResource: "Hoobastank - The Reason", withExtension: "mp3"),
            Bundle.main.url(forResource: "Goo Goo Dolls - Iris", withExtension: "mp3"),
            Bundle.main.url(forResource: "Pink Floyd - Wish You Were Here", withExtension: "mp3"),
            Bundle.main.url(forResource: "Incubus - Drive", withExtension: "mp3"),
            Bundle.main.url(forResource: "Foo Fighters - Everlong", withExtension: "mp3"),
            Bundle.main.url(forResource: "Stone Temple Pilots - Interstate Love Song", withExtension: "mp3"),
            Bundle.main.url(forResource: "Jeff Buckley - Last Goodbye", withExtension: "mp3"),
            Bundle.main.url(forResource: "Guns N' Roses - November Rain", withExtension: "mp3"),
            Bundle.main.url(forResource: "Red Hot Chili Peppers - Under The Bridge", withExtension: "mp3")
        ]
        
        
        for songURL in songs {
            if let url = songURL {
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.prepareToPlay()
                    arr.append(audioPlayer)
                } catch {
                    print("Error initializing AVAudioPlayer for \(url): \(error)")
                }
            } else {
                print("Song URL not found in bundle.")
            }
        }
        
        updateSongUI()
        
        
        
    }
    
    func updateSongUI(){
        albumCover.image = covers[index]
        name.text = artist[index]
        song.text = songtitle[index]
    }
    
    
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        if arr[index].isPlaying {
            arr[index].pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            arr[index].play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        isPlaying.toggle()
    }
    
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        arr[index].stop()
        
        if (index >= arr.count - 1){
            index = 0
        } else {
            index += 1
        }
        
        arr[index].currentTime = 0
        arr[index].play()
        updateSongUI()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        arr[index].stop()
        
        if (index == 0){
            /* could do without -> */ print("You're at the beginning of the playlist")
            arr[index].play()
        } else {
            index -= 1
        }
        
        arr[index].currentTime = 0
        arr[index].play()
        updateSongUI()
    }
    
    @IBAction func volumeSlider(_ sender: UISlider) {
        arr[index].volume = sender.value
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        favButton.setImage(UIImage(systemName: "star.circle.fill"), for: .normal)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let favoriteSong = (artist: artist[index], song: songtitle[index], cover: covers[index])
        appDelegate.favorites.append(favoriteSong)
        
        print("Added to Favorites: \(favoriteSong)")
    }

    @IBAction func viewFavoritesTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toFavorites", sender: self)
    }

    
    
    
}
 

   
    
    
    

    
   

    
    
    
    // ---------------------------------------------
    
   // @IBAction func playPauseTapped(_ sender: UIButton) {
    //            if isPlaying {
    //                queuePlayer?.pause()
    //                playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    //
    //            } else {
    //                queuePlayer?.play()
    //                playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    //            }
    //            isPlaying.toggle()
    //        print(queuePlayer?.items())
    //        }
    
//
//    @IBAction func skipButtonTapped(_ sender: UIButton) {
//        queuePlayer?.advanceToNextItem()
//    }
//    
//    @IBAction func backButtonTapped(_ sender: UIButton) {
//       
//        print("Back button functionality needs additional logic to go to the previous track.")
//    }
//}

      
//        creep = Song(songName:"Creep", imageName: "creep-ep", audioFile:"Radiohead - creep.mp3", artist: "Radiohead")
        
       
        
//        print(creep)
        
        
        
    
    
