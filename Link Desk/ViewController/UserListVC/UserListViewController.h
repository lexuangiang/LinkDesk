//
//  UserListViewController.h
//  Link Desk
//
//  Created by GiangLe on 3/11/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "ViewController.h"

@interface UserListViewController : ViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray  *arrayForBool;
    NSArray *sectionTitleArray;
}
@property (weak, nonatomic) IBOutlet UITableView *expandableTableView;

@end
