//
//  UserListTable.h
//  Link Desk
//
//  Created by GiangLe on 3/14/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListTable : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgFrame;
@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (strong, nonatomic) IBOutlet UIImageView *imgIconStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPosition;

@property (strong, nonatomic) IBOutlet UIButton *btnAction;

@end
