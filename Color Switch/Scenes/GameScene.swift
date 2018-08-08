//
//  GameScene.swift
//  Color Switch
//
//  Created by Raghav Prakash on 8/7/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	
	//MARK: - Declare spriteNode instances
	let colorCircle = SKSpriteNode(imageNamed: "ColorCircle")
	let ball = SKSpriteNode(imageNamed: "ball")
	
	//MARK: - When moved to scene, layout scene with spritenodes.
    override func didMove(to view: SKView) {
		setBackGroundColor(red: 44/255, green: 62/255, blue: 80/255)
		addColorCircleToView()
		addBallToView()
    }
	
	//MARK: - Set background color and Add colorCircle and ball to Scene view.
	func setBackGroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
		self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
	}
	func addColorCircleToView() {
		colorCircle.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
		colorCircle.position = CGPoint(x: frame.midX, y: frame.minY + colorCircle.size.height)
		self.addChild(colorCircle)
	}
	func addBallToView() {
		ball.size = CGSize(width: 30.0, height: 30.0)
		ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height)
		self.addChild(ball)
	}
}
