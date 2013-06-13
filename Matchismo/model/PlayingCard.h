//
//  Card.h
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 01/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;

@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;

+(NSUInteger) maxRank;
@end
