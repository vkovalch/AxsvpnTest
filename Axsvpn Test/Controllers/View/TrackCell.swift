//
//  TrackCell.swift
//  Axsvpn Test
//
//  Created by Vladimir Kovalchuk on 05.06.2022.
//

import UIKit
import AVFoundation

enum MusicState {
    case play
    case pause
    case stop
}

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var audioPlayer = AVAudioPlayer()
    let data: Data? = nil
    var timer : Timer? = nil
    var url: String = ""
    var musicState: MusicState = .stop {
        didSet {
            switch musicState {
            case .play:
                //                displayLink.isPaused = false
                stateImage.image = UIImage(systemName: "pause")
                
                if data != nil {
                    audioPlayer.play()
                } else {
                    if let _url = URL(string: url) {
                        DispatchQueue.global(qos: .userInitiated).async {
                            let data = NSData(contentsOf: _url) as! Data
                            
                            DispatchQueue.main.async {
                                do {
                                    
                                    self.audioPlayer = try AVAudioPlayer.init(data: data)
                                    self.audioPlayer.prepareToPlay()
                                    self.audioPlayer.delegate = self
                                    self.audioPlayer.volume = 1
                                    self.audioPlayer.play()
                                }catch {
                                    
                                }
                            }
                        }
                        
                        
                        
                    }
                }
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self.updatePlaybackStatus()
                }
            case .pause:
                stateImage.image = UIImage(systemName: "play")
                audioPlayer.pause()
                timer?.invalidate()
            case .stop:
                stateImage.image = UIImage(systemName: "play")
                timer?.invalidate()
                audioPlayer.stop()
                progressBar.progress = 0
            }
        }
    }
    //    lazy var displayLink: CADisplayLink = CADisplayLink(target: self, selector: #selector(updatePlaybackStatus))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapState = UITapGestureRecognizer(target: self, action: #selector(playStop))
        self.stateImage.addGestureRecognizer(tapState)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc
    func updatePlaybackStatus() {
        let progress = Float(audioPlayer.currentTime / audioPlayer.duration)
        progressBar.progress = progress
    }
    
    @objc private func playStop() {
//        audioPlayer.delegate = self
        let currentState: MusicState = musicState
        musicState = currentState == .play ? .pause : .play
    }
}

extension TrackCell: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
        musicState = .stop
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(error)
    }
}
