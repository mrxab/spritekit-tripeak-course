//
//  GameScene.swift
//  Tripeak_iOS
//
//  Created by CodeCaptain on 12/30/15.
//  Copyright (c) 2015 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameScene: SKScene {
  
  private var gameSetupManager: TRIGameSetupManager?
  private var gameFlowManager: TRIGameFlowManager?
  var leftPeak: [TRICard] = []
  var centerPeak: [TRICard] = []
  var rightPeak: [TRICard] = []
  var cardDeckGraphics: [TRICard] = []
  weak var currentCard: TRICard?
  
  override func didMoveToView(view: SKView) {
    
    TRIHighscoreManager.instance.reset()
    
    let gameSetupManager = TRIGameSetupManager(
      gameScene: self
    )
    self.gameSetupManager = gameSetupManager
    self.gameSetupManager!.setup()
    
    self.gameFlowManager = TRIGameFlowManager(
      gameScene: self
    )
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch = touches.first
    let point = touch!.locationInNode(self)
    self.gameFlowManager!.handleTouchStart(point)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    #if DEBUG
      self.touchesBegan(touches, withEvent: event)
    #endif
  }
  
}
