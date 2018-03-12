//
//  TopScreenViewController.m
//  Link Desk
//
//  Created by GiangLe on 3/8/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "TopScreenViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking.h"

@interface TopScreenViewController (){
    BOOL isChecked;
    NSArray *_pickerData;
    NSString *viewStatus;
    UIImage *frameOpen, *frameBusy, *frameNormal, *frameUncheckin, *checkout, *checkin, *statusNormal, *statusOpen, *statusBusy, *statusInactive, *avatarDefault ;
}
@end

@implementation TopScreenViewController
@synthesize btnUserList, btnCheckIn, btnStatus, viewPicker, frameStatus, topView, lblId, lblEnglishName, lblJapaneseName, imgAvatar;

- (void)viewDidLoad {
    [super viewDidLoad];
//    int uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];
//    NSString *stringurl = [NSString stringWithFormat:@"http://localhost:8080/linkdeskapi/api/user/%i/",uid];
//    NSURL *URL = [NSURL URLWithString:stringurl];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        lblJapaneseName.text = [responseObject objectForKey:@"jpName"];
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    lblJapaneseName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"jpName"];
    lblEnglishName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"elName"];
    lblId.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
    NSString *img = [[NSUserDefaults standardUserDefaults] stringForKey:@"avatarUrl"];
    if ([img isEqualToString:@""]){
        imgAvatar.image = avatarDefault;
    }
    else {
        imgAvatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img ]]];
    }
    //
    SWRevealViewController *revealViewController = self.revealViewController;
    UITapGestureRecognizer *tap = [revealViewController tapGestureRecognizer];
    tap.delegate = self;
    [topView addGestureRecognizer:tap];
    
    
    if ( revealViewController )
    {
        [self.btnUserList setTarget: self.revealViewController];
        [self.btnUserList setAction: @selector( rightRevealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Initialize Data
    _pickerData = @[@"オープン", @"未設定", @"ビジー"];
    // Connect data
    self.picker.dataSource = self;
    self.picker.delegate = self;
    viewPicker.frame = CGRectMake(0, 680, 378, 216);
    
    //
    frameOpen = [UIImage imageNamed:@"top_frame_open@3x.png"];
    frameBusy = [UIImage imageNamed:@"top_frame_busy@3x.png"];
    frameNormal = [UIImage imageNamed:@"top_frame_normal@3x.png"];
    frameUncheckin = [UIImage imageNamed:@"top_frame_uncheckin@3x.png"];
    //
    checkout = [UIImage imageNamed:@"top_btn_checkout@3x.png"];
    checkin = [UIImage imageNamed:@"top_btn_checkin@3x.png"];
    //
    statusNormal = [UIImage imageNamed:@"top_btn_status_normal@3x.png"];
    statusOpen = [UIImage imageNamed:@"top_btn_status_open@3x.png"];
    statusBusy = [UIImage imageNamed:@"top_btn_status_busy@3x.png"];
    statusInactive = [UIImage imageNamed:@"top_btn_status_inactive@3x.png"];
    //
    avatarDefault = [UIImage imageNamed:@"top_frame_default@3x.png"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    viewStatus = _pickerData[row];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnOk:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    viewPicker.frame = CGRectMake(0, 680, 378, 216);
    [UIView commitAnimations];
    
    if ([viewStatus isEqualToString:@"オープン"]){
        [frameStatus setImage:frameOpen];
        [btnStatus setBackgroundImage:statusOpen forState:UIControlStateNormal];
    }
    else if ([viewStatus isEqualToString:@"未設定"]){
        [frameStatus setImage:frameNormal];
        [btnStatus setBackgroundImage:statusNormal forState:UIControlStateNormal];
    }
    else {
        [frameStatus setImage:frameBusy];
        [btnStatus setBackgroundImage:statusBusy forState:UIControlStateNormal];
    }
}

- (IBAction)btnCancel:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    viewPicker.frame = CGRectMake(0, 680, 378, 216);
    [UIView commitAnimations];
}

- (IBAction)changeStatus:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    viewPicker.frame = CGRectMake(0, 451, 378, 216);
    [UIView commitAnimations];
}


- (IBAction)checkIn:(id)sender {
    if ([sender isSelected]) {
        [sender setBackgroundImage:checkin forState:UIControlStateNormal];
        [sender setSelected:NO];
        btnStatus.enabled = false;
        [frameStatus setImage:frameUncheckin];
        [btnStatus setBackgroundImage:statusInactive forState:UIControlStateNormal];

    } else {
        [sender setBackgroundImage:checkout forState:UIControlStateSelected];
        [sender setSelected:YES];
        btnStatus.enabled = true;
        [frameStatus setImage:frameNormal];
        [btnStatus setBackgroundImage:statusNormal forState:UIControlStateNormal];
    }
    
}
@end