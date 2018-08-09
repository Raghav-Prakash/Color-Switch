//
//  MenuScene.swift
//  Color Switch
//
//  Created by Raghav Prakash on 8/9/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
	
	//MARK: - When scene gets loaded, set background color and add logo and labels
	override func didMove(to view: SKView) {
		setBackGroundColor(red: 44/255, green: 62/255, blue: 80/255)
		
		addLogo()
		addLabels()
	}
	
	//MARK: - Set background color
	func setBackGroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
		self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
	}
	
	//MARK: - Add logo and labels
	func addLogo() {
		let logo = SKSpriteNode(imageNamed: "logo")
		
		logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
		logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
		
		self.addChild(logo)
	}
	func addLabels() {
		let playLabel = SKLabelNode(text: "Tap Anywhere to Play")
		playLabel.fontName = "AvenirNext-Bold"
		playLabel.fontSize = CGFloat(35.0)
		playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
		self.addChild(playLabel)
		
		let highestScoreLabel = SKLabelNode(text: "High Score: ")
		highestScoreLabel.fontName = "AvenirNext-Bold"
		highestScoreLabel.fontSize = CGFloat(30.0)
		highestScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highestScoreLabel.frame.size.height*4)
		self.addChild(highestScoreLabel)
		
		let recentScoreLabel = SKLabelNode(text: "Recent Score: ")
		recentScoreLabel.fontName = "AvenirNext-Bold"
		recentScoreLabel.fontSize = CGFloat(30.0)
		recentScoreLabel.position = CGPoint(x: frame.midX, y: highestScoreLabel.position.y - recentScoreLabel.frame.size.height*2)
		self.addChild(recentScoreLabel)
	}
	
	//MARK: - Touch anywhere to play (bring up GameScene when user touches anywhere on MenuScene screen)
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let scene = GameScene(size: view!.bounds.size)
		view!.presentScene(scene)
	}
}
