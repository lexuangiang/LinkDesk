//
//  UserListViewController.m
//  Link Desk
//
//  Created by GiangLe on 3/11/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "UserListViewController.h"
#import "AFNetworking.h"
#import "UserListTable.h"

@interface UserListViewController ()

@end

@implementation UserListViewController{
    NSArray *employees, *desks;
    NSMutableArray *arrData;
    NSMutableString *status;
    UIImage *imgStatusOpen, *imgStatusNormal, *imgStatusBusy, *imgReservInactive, *imgReservOn, *imgReservOff, *imgFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    status = [NSString stringWithFormat:@"open"];
    employees = [NSArray arrayWithObjects:@"鈴木 健二", @"吉田 光一", @"木村 次郎", @"佐藤 ともみ", @"高橋 恵", nil];
    desks = [NSArray arrayWithObjects:@"5F-1-20", @"5F-2-15", @"5F-1-15", @"4F-2-10", @"2F-1-1", nil];
    
    imgFrame = [UIImage imageNamed:@"list_icon_frame@3x.png"];
    imgStatusNormal = [UIImage imageNamed:@"list_icon_status_normal@3x.png"];
    imgStatusOpen = [UIImage imageNamed:@"list_icon_status_open@3x.png"];
    imgStatusBusy = [UIImage imageNamed:@"list_icon_status_busy@3x.png"];
    imgReservOn = [UIImage imageNamed:@"list_btn_reserv_on@3x.png"];
    imgReservOff = [UIImage imageNamed:@"list_btn_reserv_off@3x.png"];
    imgReservInactive = [UIImage imageNamed:@"list_btn_reserv_inactive@3x.png"];
    
//    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/linkdeskapi/api/user/"];
    
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        //NSLog(@"JSON: %@", responseObject);
//        arrData=[[NSMutableArray alloc]initWithArray:responseObject];
////        NSData *jsonObject=[NSJSONSerialization
////                                  JSONObjectWithData:responseObject
////                                  options:NSJSONReadingMutableLeaves
////                                  error:nil];
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [employees count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *simpleTableIdentifier = @"SimpleTableCell";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
//    //cell.textLabel.text = [recipes objectAtIndex:indexPath.row] ;
//   // NSDictionary* tempDict = [arrData objectAtIndex:indexPath.row];
//    //cell.textLabel.text = [tempDict objectForKey:@"name"];
//    //NSLog(@"indexpath.row: %@", [[arrData objectAtIndex:0] objectForKey:@"name"]);
//    //cell.textLabel.text = [[arrData objectAtIndex:indexPath.row] objectForKey:@"name"];
//    //NSLog(@"JSON: %@", [[arrData objectAtIndex:indexPath.row] objectForKey:@"name"]);
//    return cell;
    static NSString *simpleTableIdentifier = @"customTableCell";
    
    UserListTable *cell = (UserListTable *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.imgFrame setImage:imgFrame];
    cell.lblName.text = [employees objectAtIndex:indexPath.row];
    //cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    cell.lblPosition.text = [desks objectAtIndex:indexPath.row];
    if ([status isEqualToString:@"open"]){
        [cell.imgIconStatus setImage:imgStatusOpen];
        [cell.btnAction setBackgroundImage:imgReservInactive forState:UIControlStateNormal];
    }
    else if ([status isEqualToString:@"busy"]){
        [cell.imgIconStatus setImage:imgStatusBusy];
        [cell.btnAction setBackgroundImage:imgReservOff forState:UIControlStateNormal];
    }
    else {
        [cell.imgIconStatus setImage:imgStatusNormal];
        [cell.btnAction setBackgroundImage:imgReservOn forState:UIControlStateNormal];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
