//
//  Settings.swift
//  Color Switch
//
//  Created by Raghav Prakash on 8/8/18.
//  Copyright © 2018 Raghav Prakash. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
	static let none : UInt32 = 0 					// no physics simulation
	static let ballCategory : UInt32 = 0x1 			// 01
	static let switchCategory : UInt32 = 0x1 << 1 	// 10
}
