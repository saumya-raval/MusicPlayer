//
//  ViewController.swift
//  MusicPlayerX8
//
//  Created by Saumya Raval on 2/24/17.
//  Copyright © 2017 PlayAgain. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!
    
    var playerItem: AVPlayerItem!
    var player: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/fir-sociallogin-ae127.appspot.com/o/05%20Cutiepie%20(Ae%20Dil%20Hai%20Mushkil).mp3?alt=media&token=1cac8470-08d4-4482-9cf5-91de3569dde7")
        
        playerItem = AVPlayerItem(url: url as! URL)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        self.view.layer.addSublayer(playerLayer)
        
        playBtn.addTarget(self, action: #selector(playBtnTapped), for: .touchUpInside)
        
        
    }
    
    func playBtnTapped(sender: AnyObject){
        if player.rate == 0 {
            player.play()
            playBtn.setImage(UIImage(named:"pause-button-outline_318-40569"), for: .normal)
        } else {
            player.pause()
            playBtn.setImage(UIImage(named:"play-button_318-42541"), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: Selector(("finishedPlaying:")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func finishedPlaying(myNotification: NSNotification) {
        playBtn.setImage(UIImage(named:"play-button_318-42541"), for: .normal)
        
        let stopPlayerItem: AVPlayerItem = myNotification.object as! AVPlayerItem
        stopPlayerItem.seek(to: kCMTimeZero)
    }
    

}













