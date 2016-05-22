//
//  ViewController.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/2/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    __weak IBOutlet UILabel *lblChallenge;
    __weak IBOutlet UILabel *lblPunishment;
    __weak IBOutlet UIView *punishmentView;
    __weak IBOutlet NSLayoutConstraint *punishmentViewHeightConstraint;
}

- (IBAction)eventSelectedNext:(id)sender;
- (IBAction)eventSelectedNextPunihsment:(id)sender;
- (IBAction)eventSelectAcceptChallange:(id)sender;
- (IBAction)eventSelectedClosePunishmentView:(id)sender;

@end

