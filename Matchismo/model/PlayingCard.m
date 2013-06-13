//
//  Card.m
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 01/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *) rankStrings
{
    return @[@"?", @"A",@"2", @"3",
             @"4",@"5", @"6", @"7",@"8",
             @"9",@"10",@"J",@"Q", @"K"];
}

+(NSUInteger) maxRank
{
    return [PlayingCard rankStrings].count-1;
}

-(void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *) anotherCards {
    int score = 0;
    if (anotherCards && [anotherCards count] ==1) {
        PlayingCard *card = [anotherCards lastObject];
        if ([self.suit isEqualToString:card.suit]) {
            score = 1;
        } else if (self.rank == card.rank) {
            score = 4;
        }
    }
    return score;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@%@", self.suit, [[PlayingCard rankStrings]objectAtIndex:self.rank]];
}
@end
