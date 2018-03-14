//
//  SplashScreenViewController.m
//  Link Desk
//
//  Created by GiangLe on 3/6/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController
@synthesize imageSplash;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self performSelector:@selector(showLoginScreen) withObject:nil afterDelay:5.0];
    //fade in
    imageSplash.alpha = 1.0;
    [UIView animateWithDuration:0.0f animations:^{
        [imageSplash setAlpha:1.0f];
    } completion:^(BOOL finished) {

        //fade out
        [UIView animateWithDuration:2.0f animations:^{
            [imageSplash setAlpha:0.0f];
        } completion:nil];

    }];
    
    int SavedInfo = [[NSUserDefaults standardUserDefaults] integerForKey:@"info"];
    if (SavedInfo == 1){
        [self performSelector:@selector(showTopScreen) withObject:nil afterDelay:3];
        NSLog(@"thong tin o flash: %i", SavedInfo);
    }
    else {
        [self performSelector:@selector(showLoginScreen) withObject:nil afterDelay:3];
    }
}
- (void)showLoginScreen {
    [self performSegueWithIdentifier:@"SplashToLogin" sender:self];
}
- (void)showTopScreen {
    [self performSegueWithIdentifier:@"SplashToTop" sender:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
