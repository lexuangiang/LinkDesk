//
//  TopScreenViewController.h
//  Link Desk
//
//  Created by GiangLe on 3/8/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "ViewController.h"

@interface TopScreenViewController : ViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnUserList;
@property (strong, nonatomic) IBOutlet UIButton *btnCheckIn;
@property (strong, nonatomic) IBOutlet UIButton *btnStatus;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UIView *viewPicker;
@property (strong, nonatomic) IBOutlet UIImageView *frameStatus;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *lblJapaneseName;
@property (strong, nonatomic) IBOutlet UILabel *lblEnglishName;
@property (strong, nonatomic) IBOutlet UILabel *lblId;
@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;

- (IBAction)btnOk:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)changeStatus:(id)sender;
- (IBAction)checkIn:(id)sender;

@end
