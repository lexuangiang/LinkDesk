//
//  LoginViewController.h
//  Link Desk
//
//  Created by GiangLe on 3/8/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : ViewController
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnShowPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblMessage;

- (IBAction)showPassword:(id)sender;
- (IBAction)Login:(id)sender;
- (IBAction)returnView:(id)sender;

@end
