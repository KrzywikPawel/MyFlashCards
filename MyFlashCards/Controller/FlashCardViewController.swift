//
//  FlashCardViewController.swift
//  MyFlashCards
//
//  Created by Pawel Krzywik on 19/02/2020.
//  Copyright © 2020 Pawel Krzywik. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {
    
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var flashCardView: UIView!
    @IBOutlet weak var upThumbImageView: UIImageView!
    @IBOutlet weak var downThumbImageView: UIImageView!
    var divisor: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
        // Do any additional setup after loading the view.
    }
    @IBAction func flashCardTapGesture(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: flashCardView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
    @IBAction func flashCardPanGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let xFromCenter = card.center.x - view.center.x
        let scale = min(100/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        if xFromCenter > 0 {
            upThumbImageView.image = UIImage(named: "thumbUp")
            upThumbImageView.tintColor = .green
            upThumbImageView.alpha = abs(xFromCenter) / view.center.x
        } else {
            downThumbImageView.image = UIImage(named: "thumbDown")
            downThumbImageView.tintColor = .red
            downThumbImageView.alpha = abs(xFromCenter) / view.center.x
        }
        
        //        MARK: tutaj dodanie next fisha
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                    card.alpha = 0
                    
                }
                
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                    card.alpha = 0
                }
                return
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
