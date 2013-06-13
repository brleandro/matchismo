//
//  Deck.h
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 04/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard:(Card *)card atTop:(BOOL) atTop;
- (Card *) drawingRandomCard;
@end
