//
//  UserListTable.m
//  Link Desk
//
//  Created by GiangLe on 3/14/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "UserListTable.h"

@implementation UserListTable
@synthesize imgFrame, imgAvatar, imgIconStatus, lblName, lblPosition, btnAction;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
