//
//  ViewController.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/2/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "ViewController.h"
#import "Parse.h"
#import "Challenge.h"
#import "Punishment.h"

@implementation ViewController {
    NSArray *challenges;
    NSArray *punishments;
    NSArray *challengesFromParse;
    NSArray *punishmentsFromParse;
    NSInteger number;
    UIToolbar *toolbarBackground;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getChallenges];
    [self getPunishments];
    number = 0;
    [self setupChallengesArray];
    [self setupPunishmentsArray];
    [self setupToolbar];
}

- (void)setupToolbar
{
    toolbarBackground = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height - punishmentView.frame.size.height)];
    toolbarBackground.alpha = 0.0;
    toolbarBackground.backgroundColor = [UIColor colorWithRed:95/255.0 green:53/255.0 blue:93/255.0 alpha:1];
    [self.view insertSubview:toolbarBackground belowSubview:punishmentView];

}

- (void)setupChallengesArray {
    challenges = @[@"Put on a blindfold and slow dance with a player. See if you can guess who it is by touch alone.",
                   @"Go to the kitchen and eat something that is not meant to be eaten alone (like chili powder, pepper, etc).",
                   @"You have to remain perfectly sill for one minute. Meanwhile another player is going to attempt to get you to move buy whatever means he/she can think of.",
                   @"Become the slave of another player of your choosing for 10 minutes.",
                   @"Go to the bathroom and change, you must go commando for the rest of the game.",
                   @"Touch your nose with your tongue. If you are unable to do this you must touch another players nose with your tongue."];
}

- (void)setupPunishmentsArray {
    punishments = @[@"Put on a blindfold and slow dance with a player. See if you can guess who it is by touch alone.",
                    @"Go to the kitchen and eat something that is not meant to be eaten alone (like chili powder, pepper, etc).",
                    @"You have to remain perfectly sill for one minute. Meanwhile another player is going to attempt to get you to move buy whatever means he/she can think of.",
                    @"Become the slave of another player of your choosing for 10 minutes.",
                    @"Go to the bathroom and change, you must go commando for the rest of the game.",
                    @"Touch your nose with your tongue. If you are unable to do this you must touch another players nose with your tongue."];
}

- (IBAction)eventSelectedNext:(id)sender
{
    //[self randomChallenge] <==> randomChallenge()
    int randomIndex = arc4random() % challengesFromParse.count;
    Challenge *currentChallenge = [challengesFromParse objectAtIndex:randomIndex];
    lblChallenge.text = currentChallenge.challenges;
}

- (IBAction)eventSelectedNextPunihsment:(id)sender
{
    int randomIndex = arc4random() % punishmentsFromParse.count;
    Punishment *currentPunishment = [punishmentsFromParse objectAtIndex:randomIndex];
    lblPunishment.text = currentPunishment.punishments;
}

//this is actually decline challenge
- (IBAction)eventSelectAcceptChallange:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        punishmentViewHeightConstraint.constant = 300;
        [self.view layoutIfNeeded];
        toolbarBackground.alpha = 0.6;
    }];
}

- (IBAction)eventSelectedClosePunishmentView:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        punishmentViewHeightConstraint.constant = 0;
        [self.view layoutIfNeeded];
        toolbarBackground.alpha = 0;
    }];
}

#pragma mark -
#pragma mark API Call to Parse for Challenges

- (void)getChallenges
{
    PFQuery *query = [PFQuery queryWithClassName:@"Challenge"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            challengesFromParse = [objects mutableCopy];
        }
        else {
            NSLog(@"ERROR: %@", [error localizedDescription]);
        }
    }];
}

#pragma mark -
#pragma mark API Call to Parse for Punishments

- (void)getPunishments
{
    PFQuery *query = [PFQuery queryWithClassName:@"Punishment"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            punishmentsFromParse = [objects mutableCopy];
        }
        else {
            NSLog(@"ERROR: %@", [error localizedDescription]);
        }
    }];
}

@end