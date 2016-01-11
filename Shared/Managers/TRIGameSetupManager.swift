//
//  TRIGameSetupManager.swift
//  Tripeak
//
//  Created by CodeCaptain on 1/11/16.
//  Copyright © 2016 CodeCaptain. All rights reserved.
//

import SpriteKit

class TRIGameSetupManager: NSObject {
  
  private weak var gameScene: TRIGameScene?
  private var cardDeck: [TRICardModel] = []

  init(gameScene: TRIGameScene) {
    super.init()
    self.gameScene = gameScene
  }
  
  func setup() {
    self.createDeck()
    self.setupTripeak()
  }
  
  func createDeck() {
    for suit: Suit in Suit.allValues {
      for rank: Rank in Rank.allValues {
        self.cardDeck.append(
          TRICardModel(suit: suit, rank: rank)
        )
      }
    }
  }
  
  func getRandomCard() -> TRICardModel {
    let index = UInt32(self.cardDeck.count)
    let randomIndex: Int = Int(arc4random_uniform(index))
    let retVal = self.cardDeck[randomIndex]
    self.cardDeck.removeAtIndex(randomIndex)
    
    return retVal
  }
  
  func setupPeakWithTopPositionAtPoint(
    point: CGPoint) -> [TRICard] {
      let dummyCard = TRICard()
      let offset = TRIGameSceneLayout.tripeakOffsetBetweenCards
      var x: CGFloat = 0
      var y: CGFloat = 0
      
      // Top card
      x = point.x
      y = point.y - dummyCard.size.height / 2
      let topCard = self.createCard(x, y: y)
      
      // Center 2 cards
      x = topCard.position.x - topCard.size.width / 2 - offset
      y = topCard.position.y - topCard.size.height / 2
      let centerLeftCard = self.createCard(x, y: y)
      
      x = topCard.position.x + topCard.size.width / 2 + offset
      y = topCard.position.y - topCard.size.height / 2
      let centerRightCard = self.createCard(x, y: y)
      
      // Bottom 3 cards
      x = centerLeftCard.position.x - centerLeftCard.size.width / 2
      x -= offset
      y = centerLeftCard.position.y - centerLeftCard.size.height / 2
      let bottomLeftCard = self.createCard(x, y: y)
      
      x = topCard.position.x
      y = centerLeftCard.position.y - centerLeftCard.size.height / 2
      let bottomCenterCard = self.createCard(x, y: y)
      
      x = centerRightCard.position.x + centerRightCard.size.width / 2
      x += offset
      y = centerLeftCard.position.y - centerLeftCard.size.height / 2
      let bottomRightCard = self.createCard(x, y: y)
      
      return [
        topCard,
        centerLeftCard, centerRightCard,
        bottomLeftCard, bottomCenterCard, bottomRightCard
      ]
      
  }
  
  func setupTripeak() {
  
    self.setupPeakWithTopPositionAtPoint(
      CGPoint(
        x: self.gameScene!.size.width / 2, y: 300
      )
    )
    
  }
  
  private func createCard(x: CGFloat, y: CGFloat) -> TRICard {
    let card = TRICard(
      cardModel: self.getRandomCard()
    )
    card.position = CGPoint(x: x, y: y)
    self.gameScene!.addChild(card)
    
    return card
  }
  
}
