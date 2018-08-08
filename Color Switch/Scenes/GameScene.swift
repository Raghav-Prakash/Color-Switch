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
		setUpColorCircleInView()
		setUpBallInView()
		
		addPhysicsToColorCircle()
		addPhysicsToBall()
		
		slowDownGravityInScene()
		
		addSpriteNodesToView()
    }
	
	//MARK: - Set background color and set up colorCircle and ball in the Scene view.
	func setBackGroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
		self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
	}
	func setUpColorCircleInView() {
		colorCircle.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
		colorCircle.position = CGPoint(x: frame.midX, y: frame.minY + colorCircle.size.height)
	}
	func setUpBallInView() {
		ball.size = CGSize(width: 30.0, height: 30.0)
		ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height)
	}
	
	//MARK: - Set up the physics in the sprite nodes
	func addPhysicsToColorCircle() {
		colorCircle.physicsBody = SKPhysicsBody(circleOfRadius: colorCircle.size.width/2)
		colorCircle.physicsBody!.categoryBitMask = PhysicsCategories.switchCategory
		
		//Prevent the colorCircle to drop below the frame.
		colorCircle.physicsBody?.isDynamic = false
	}
	func addPhysicsToBall() {
		ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
		ball.physicsBody!.categoryBitMask = PhysicsCategories.ballCategory
		
		// Have a check whether the ball has a contact with colorCircle but we prevent the ball from colliding with colorCircle
		ball.physicsBody!.contactTestBitMask = PhysicsCategories.switchCategory
		ball.physicsBody!.collisionBitMask = PhysicsCategories.none
	}
	
	//MARK: - Slow down the fall speed in the gravity of the scene.
	func slowDownGravityInScene() {
		self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
	}
	
	//MARK: - Add all the setup sprite nodes to the scene view
	func addSpriteNodesToView() {
		self.addChild(colorCircle)
		self.addChild(ball)
	}
}
