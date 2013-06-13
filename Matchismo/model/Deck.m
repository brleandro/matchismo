//
//  Deck.m
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 04/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void) addCard:(Card *)card atTop:(BOOL) atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject: card];
    }
}
- (Card *) drawingRandomCard {
    Card *ramdonCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        ramdonCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return ramdonCard;
}

@end
