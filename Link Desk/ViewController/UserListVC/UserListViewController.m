//
//  UserListViewController.m
//  Link Desk
//
//  Created by GiangLe on 3/11/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "UserListViewController.h"
#import "AFNetworking.h"

@interface UserListViewController ()

@end

@implementation UserListViewController{
    NSArray *recipes;
    NSMutableArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/linkdeskapi/api/user/"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        arrData=[[NSMutableArray alloc]initWithArray:responseObject];
//        NSData *jsonObject=[NSJSONSerialization
//                                  JSONObjectWithData:responseObject
//                                  options:NSJSONReadingMutableLeaves
//                                  error:nil];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    //cell.textLabel.text = [recipes objectAtIndex:indexPath.row] ;
   // NSDictionary* tempDict = [arrData objectAtIndex:indexPath.row];
    //cell.textLabel.text = [tempDict objectForKey:@"name"];
    //NSLog(@"indexpath.row: %@", [[arrData objectAtIndex:0] objectForKey:@"name"]);
    //cell.textLabel.text = [[arrData objectAtIndex:indexPath.row] objectForKey:@"name"];
    //NSLog(@"JSON: %@", [[arrData objectAtIndex:indexPath.row] objectForKey:@"name"]);
    return cell;
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
