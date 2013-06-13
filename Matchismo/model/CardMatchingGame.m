//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 05/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

@property (nonatomic) int score;

@property (nonatomic) NSMutableArray *cards;

@property Card *one;

@property Card *two;

@property Card *three;

@property (nonatomic) MATCH_MODE matchMode;

@end
@implementation CardMatchingGame

- (id) initWithCardCount:(int)count
               usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawingRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
            
        }
    }
    
return self;
}

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#define MATCH_BONUS 4
#define MATCH_PENALTY 2
#define FLIP_COST 1
- (void) flipCardAtIndex:(int) index {
    
    Card *card = [self cardAtIndex:index];
    bool fliped = card && !card.isFaceUp && !card.isUnplayable && [self flipCard: card];
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp && fliped ) {
            for (Card *other in self.cards) {
                if (other.isFaceUp && !other.isUnplayable) {
                    int matchScore = [card match:@[other]];
                    if (matchScore) {
                        card.unplayable = YES;
                        other.unplayable = YES;
                        self.score += matchScore  * MATCH_BONUS;
                        [self deselect: card];
                        [self deselect: other];
                    } else {
                        self.score -= MATCH_PENALTY;
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        if (fliped || card.isFaceUp) {
            card.faceUp = !card.faceUp;
        }
        if (!card.isFaceUp) {
            [self deselect:card];
        }
    }
}

- (Card *)cardAtIndex:(int) index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)deselect:(Card *) card
{
    if (_one == card) {
        _one = nil;
    }
    
    if (_two == card) {
        _two = nil;
    }
    
    if (_three == card) {
        _three = nil;
    }
    
    
}

- (bool) flipCard:(Card *) card
{
    if (!_one) {
        _one = card;
        return YES;
    }
    
    if (!_two) {
        _two = card;
        return YES;
    }
    
    if (self.matchMode == MATCH_MODE_3 && !_three) {
        _three = card;
        return YES;
    }
    return NO;
}

- (NSString *) gameDescription
{
    
    if (_one && !_two) {
        return [NSString stringWithFormat:@"Flipped up %@",_one];
    }
    
    if (_one && _two) {
        int matchScore = [_one match:@[_two]];
        if (matchScore) {
            return [NSString stringWithFormat:@"Matched %@ & %@ for %i",_one, _two, matchScore];
        } else {
             return [NSString stringWithFormat:@"%@ & %@ dont match!",_one, _two];
        }
    }
    return nil;
    
}

- (void)reDeal
{
     for (Card *card in self.cards) {
         card.faceUp = false;
         card.unplayable = false;
     }
    self.score = 0;
}

- (MATCH_MODE) matchMode
{
    _matchMode = !_matchMode ? MATCH_MODE_2 : _matchMode;
    return _matchMode;
}

- (void)changeMatchMode
{
    if (self.matchMode == MATCH_MODE_2) {
        self.matchMode = MATCH_MODE_3;
    } else {
        self.matchMode = MATCH_MODE_2;
    }
}


@end
