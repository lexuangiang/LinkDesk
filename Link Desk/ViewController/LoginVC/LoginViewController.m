//
//  LoginViewController.m
//  Link Desk
//
//  Created by GiangLe on 3/8/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtUsername, txtPassword, btnShowPassword, lblMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // custom textfield txtusername
    CALayer *borderUsername = [CALayer layer];
    CGFloat borderWidthUsername = 1;
    borderUsername.borderColor = [UIColor darkGrayColor].CGColor;
    borderUsername.frame = CGRectMake(0, txtUsername.frame.size.height - borderWidthUsername, txtUsername.frame.size.width, txtUsername.frame.size.height);
    borderUsername.borderWidth = borderWidthUsername;
    [txtUsername.layer addSublayer:borderUsername];
    txtUsername.layer.masksToBounds = YES;
    
    // custom textfield password
    CALayer *borderPassword = [CALayer layer];
    CGFloat borderWidthPassword = 1.25;
    borderPassword.borderColor = [UIColor darkGrayColor].CGColor;
    borderPassword.frame = CGRectMake(0, txtPassword.frame.size.height - borderWidthPassword, txtPassword.frame.size.width, txtPassword.frame.size.height);
    borderPassword.borderWidth = borderWidthPassword;
    [txtPassword.layer addSublayer:borderPassword];
    txtPassword.layer.masksToBounds = YES;
    
    // set focus on Username textfield
    [txtUsername becomeFirstResponder];
    // Call standartUserDefaults to check
    int sodaluu = [[NSUserDefaults standardUserDefaults] integerForKey:@"info"];
    NSLog(@"thong tin o login: %i", sodaluu);
    //    if (sodaluu == 1){
    //        NSLog(@"dit con me da luu roi");
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTopScreen {
    [self performSegueWithIdentifier:@"LoginToTop" sender:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showPassword:(id)sender {
    NSLog(@"clicked show password");
    UIImage *on = [UIImage imageNamed:@"login_btn_eye_on@3x"];
    UIImage *off = [UIImage imageNamed:@"login_btn_eye_off@3x"];
    if ([sender isSelected]) {
        [sender setImage:off forState:UIControlStateNormal];
        [sender setSelected:NO];
        txtPassword.secureTextEntry = true;
    } else {
        [sender setImage:on forState:UIControlStateSelected];
        [sender setSelected:YES];
        txtPassword.secureTextEntry = false;
    }
}

- (IBAction)Login:(id)sender {
    NSLog(@"clicked login button");
    // tao du lieu gia
    NSString *username = [NSString stringWithFormat:@"giang"];
    NSString *password = [NSString stringWithFormat:@"giang123"];
    
    // lay du lieu tu textfield
    NSString *user_name = txtUsername.text;
    NSString *pass_word = txtPassword.text;
    
    // connect server
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSDictionary *params = @{@"username": user_name,
//                             @"password": pass_word};
//    [manager POST:@"http://localhost:8080/linkdeskapi/api/login/" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        lblMessage.text = @"";
//        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"info"];
//        [[NSUserDefaults standardUserDefaults] setValue:[responseObject objectForKey:@"userId"] forKey:@"uid"];
//        [[NSUserDefaults standardUserDefaults] setValue:[responseObject objectForKey:@"jpName"] forKey:@"jpName"];
//        [[NSUserDefaults standardUserDefaults] setValue:[responseObject objectForKey:@"name"] forKey:@"elName"];
//        [[NSUserDefaults standardUserDefaults] setValue:[responseObject objectForKey:@"avatarUrl"] forKey:@"avatarUrl"];
//        [self performSelector:@selector(showTopScreen) withObject:nil afterDelay:0];
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        lblMessage.text = @"メールアドレスまたはパスワードが違います";
//    }];
    
    // Check space indent in textfield
    if ([user_name isEqualToString:@""] || [pass_word isEqualToString:@""]){
        NSLog(@"Empty username or password");
    }
    else if ([username isEqualToString:user_name] && [password isEqualToString:pass_word]){
        NSLog(@"login ok ");
        lblMessage.text = @"";
        //        // gan du lieu vao userdefault
        //        [SaveData setObject:username forKey:@“UserLoginInfo”];
        //        [SaveData synchronize];
        //        //
        //        if ([SaveData stringForKey:@“UserLoginInfo”]) {
        //            username = [SaveData stringForKey:@“UserLoginInfo”];
        //        }
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"info"];
        //          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //          [defaults setObject:user_name forKey:@"bookmarks"];
        [self performSelector:@selector(showTopScreen) withObject:nil afterDelay:0];
    }
    else {
        NSLog(@"xin loi ban deo login vao duoc dau vi sai thong tin nhe");
        lblMessage.text = @"メールアドレスまたはパスワードが違います";
    }
}
@end
