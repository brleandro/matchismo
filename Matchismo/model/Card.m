    //
//  Card.m
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 04/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card



- (int)match:(NSArray *) anotherCards {
    int score = 0;
    
    for (Card *card in anotherCards) {
        if ([card.contents isEqualToString: self.contents]) {
            score = 1;
        }
    }
return score;
}

@end
