//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Leandro Orilio do Carmo on 01/06/13.
//  Copyright (c) 2013 Leandro Orilio do Carmo. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingDeck.h"
#import "CardMatchingGame.h"
@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@property (weak, nonatomic) IBOutlet UILabel *flipdesc;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

@end

@implementation CardGameViewController

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                       usingDeck: [[PlayingDeck alloc]init]];
    }
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons{
    
    _cardButtons = cardButtons;

   [self updateUI];
    
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
                [cardButton setTitle:card.contents  forState:UIControlStateSelected];
        [cardButton setTitle:card.contents  forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected =  card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        [cardButton setImage:card.isFaceUp ? nil : [UIImage imageNamed:@"backOfCard.png"] forState:UIControlStateNormal];
    }
    _flipdesc.text = [self.game gameDescription];
    self.scoreLable.text = [[NSNumber numberWithInt: [self.game score]] description];
}

-(void) setFlipCount:(int) flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %d", self.flipCount];
    self.scoreLable.text = [[NSNumber numberWithInt: [self.game score]] description];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)reDeal:(UIButton *)sender {
    [self.game reDeal];
    [self updateUI];
}


- (void)viewDidUnload {
    [self setFlipdesc:nil];
    [self setScoreLable:nil];
    [super viewDidUnload];
}
- (IBAction)matchModeChanged:(UISegmentedControl *)sender {
    [self.game changeMatchMode];
}
@end
