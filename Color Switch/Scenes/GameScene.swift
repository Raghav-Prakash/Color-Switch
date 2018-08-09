//
//  GameScene.swift
//  Color Switch
//
//  Created by Raghav Prakash on 8/7/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import SpriteKit

//MARK: - 2 enums: one for all the 4 actual colors of the colorCircle and the other for the state of the colorCircle (which color is at the top)
enum BallColors {
	static let colors = [
		UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
		UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
		UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
		UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
	]
}
enum ColorSwitchState : Int {
	case red, yellow, green, blue
}

class GameScene: SKScene {
	
	//MARK: - Declare spriteNode instances
	let colorCircle = SKSpriteNode(imageNamed: "ColorCircle")
	var ball : SKSpriteNode!
	
	//MARK: - Declare Game-logic related variables
	var currentColorIndex : Int?
	var currentColorSwitchState = ColorSwitchState.red.rawValue
	
	//MARK: - Declare score-related variables
	let scoreLabel = SKLabelNode(text: "0")
	var score = 0
	
	//MARK: - When moved to scene, layout scene with spritenodes.
    override func didMove(to view: SKView) {
		setBackGroundColor(red: 44/255, green: 62/255, blue: 80/255)
		
		setUpColorCircleInView()
		setUpBallInView()
		
		addPhysicsToColorCircle()
		addPhysicsToBall()
		
		slowDownGravityInScene()
		
		setUpScoreLabel()
		
		setSelfAsContactDelegate()
    }
	
	//MARK: - Set background color and set up colorCircle and ball in the Scene view.
	func setBackGroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
		self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
	}
	func setUpColorCircleInView() {
		colorCircle.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
		colorCircle.position = CGPoint(x: frame.midX, y: frame.minY + colorCircle.size.height)
		
		colorCircle.zPosition = ZPositions.colorCircleZ.rawValue
		
		// Add colorCircle to our scene view
		self.addChild(colorCircle)
	}
	func setUpBallInView() {
		currentColorIndex = Int(arc4random_uniform(UInt32(4)))
		ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: BallColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
		
		ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball!.size.height)
		
		// Make sure the color assigned is blended well into the ball
		ball.colorBlendFactor = 1.0
		
		// Give a name to this ball to be used in the contact delegate
		ball.name = "Ball"
		
		// Set Z-Position of ball
		ball.zPosition = ZPositions.ballZ.rawValue
		
		// Add ball to our scene view
		self.addChild(ball)
	}
	
	//MARK: - Set up the physics in the sprite nodes
	func addPhysicsToColorCircle() {
		colorCircle.physicsBody = SKPhysicsBody(circleOfRadius: colorCircle.size.width/2)
		colorCircle.physicsBody!.categoryBitMask = PhysicsCategories.switchCategory
		
		//Prevent the colorCircle to drop below the frame.
		colorCircle.physicsBody?.isDynamic = false
	}
	func addPhysicsToBall() {
		ball.physicsBody = SKPhysicsBody(circleOfRadius: (ball?.size.width)!/2)
		ball.physicsBody!.categoryBitMask = PhysicsCategories.ballCategory
		
		// Have a check whether the ball has a contact with colorCircle but we prevent the ball from colliding with colorCircle
		ball.physicsBody!.contactTestBitMask = PhysicsCategories.switchCategory
		ball.physicsBody!.collisionBitMask = PhysicsCategories.none
	}
	
	//MARK: - Slow down the fall speed in the gravity of the scene.
	func slowDownGravityInScene() {
		self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
	}
	
	//MARK: - Set self view as the delegate for the physics contact protocol
	func setSelfAsContactDelegate() {
		self.physicsWorld.contactDelegate = self
	}
	
	//MARK: - When user touches anywhere on screen, change the state of color on top of colorSwitch wheel and rotate it by 90 degrees
	func turnColorSwitchWheel() {
		currentColorSwitchState = (currentColorSwitchState + 1) % 4
		
		colorCircle.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		turnColorSwitchWheel()
	}
	
	//MARK: - When the ball color and colorSwitch color don't match
	func gameOver() {
		UserDefaults.standard.set(score, forKey: "RecentScore")
		if score > UserDefaults.standard.integer(forKey: "HighScore") {
			UserDefaults.standard.set(score, forKey: "HighScore")
		}
		
		let menuScene = MenuScene(size: view!.bounds.size)
		view!.presentScene(menuScene)
	}
	
	///MARK: - Set up score label on scene
	func setUpScoreLabel() {
		scoreLabel.fontName = "AvenirNext-Bold"
		scoreLabel.fontSize = CGFloat(60.0)
		scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
		
		scoreLabel.zPosition = ZPositions.scoreZ.rawValue
		
		self.addChild(scoreLabel)
	}
	
	//MARK: - When the ball color and colorSwitch color match, update score
	func updateScoreLabel(with score: Int) {
		scoreLabel.text = "\(score)"
	}
}

extension GameScene : SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
		
		if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
			// Before checking if the colors contacting are matching, we check if the contacting object is our "ball".
			// And if so, which object is our "ball" (bodyA or bodyB)
			if let ball = contact.bodyA.node?.name == "ball" ? contact.bodyA.node : contact.bodyB.node {
				if currentColorSwitchState == currentColorIndex {
					score += 1
					updateScoreLabel(with: score)
					
					// Fade out the ball and when that's done, de-initialize the ball and re-initialize a new one.
					ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
						ball.removeFromParent()
						
						self.setUpBallInView()
						self.addPhysicsToBall()
					})
				} else {
					gameOver()
				}
			}
		}
	}
}
