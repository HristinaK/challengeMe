//
//  AddViewController.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/16/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "AddViewController.h"
#import "UserChallenge.h"
#import "UserPunishment.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)eventSelectedCloseAddView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)eventSelectedSendChallenge:(id)sender {
    
    if (self.inputChallenge.text.length > 0) {
        UserChallenge *newRequest = [UserChallenge new];
        newRequest.uchallenge = self.inputChallenge.text;
        [newRequest saveInBackground];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucess"
                                                        message:@"Thank you!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please insert your challenge first!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (IBAction)ventSelectedSendPunishment:(id)sender {
    
    if (self.inputChallenge.text.length > 0) {
    UserPunishment *newRequest = [UserPunishment new];
    newRequest.upunishment = self.inputPunishment.text;
    [newRequest saveInBackground];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucess"
                                                    message:@"Thank you!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please insert your punishment first!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
@end
