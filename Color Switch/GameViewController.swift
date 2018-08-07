//
//  GameViewController.swift
//  Color Switch
//
//  Created by Raghav Prakash on 8/7/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
			
			// Set the scale mode to scale to fit the window
			scene.scaleMode = .aspectFill
			
			// Present the scene
			view.presentScene(scene)
			
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
