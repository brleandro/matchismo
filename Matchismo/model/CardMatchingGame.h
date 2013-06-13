//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 05/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (readonly, nonatomic) int score;

typedef enum {
    MATCH_MODE_2,
    MATCH_MODE_3
} MATCH_MODE;

@property (readonly,nonatomic) MATCH_MODE matchMode;

//designated initialize
- (id) initWithCardCount:(int)count
               usingDeck:(Deck *)deck;

- (void) flipCardAtIndex:(int)index;
 
- (Card *)cardAtIndex:(int)index;

- (NSString *) gameDescription;

- (void)reDeal;

- (void)changeMatchMode;

@end
