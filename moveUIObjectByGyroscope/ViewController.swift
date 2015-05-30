//
//  ViewController.swift
//  moveUIObjectByGyroscope
//
//  Created by shinokiryosei on 2015/05/30.
//  Copyright (c) 2015年 shinokiryosei. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    
    @IBOutlet weak var redRect: UILabel!
    
    let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {
            (unko:CMDeviceMotion!,
                error: NSError!) in println("加速度センサが監視されています")
            
            let fromX = self.redRect.center.x
            let fromY = self.redRect.center.y
            
            let xAngle = 180 * unko.attitude.roll / M_PI
            let yAngle = 180 * unko.attitude.pitch / M_PI
            
            let lenX = CGFloat(xAngle)
            let lenY = CGFloat(yAngle)
            
            var toX = fromX + lenX
            var toY = fromY + lenY
            
            let adjustX = self.redRect.frame.size.width * 0.5
            let adjustY = self.redRect.frame.size.height * 0.5
            
            
            if toX < 0 + adjustX {
                toX = 0 + adjustX
            }else if toX > width - adjustX {
                toX = width - adjustX
            }
            
            if toY < 0 + adjustY {
                toY = 0 + adjustY
            }else if toY > height - adjustY {
                toY = height - adjustY
            }
            
            self.redRect.center = CGPointMake(toX, toY)
            
        }
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

