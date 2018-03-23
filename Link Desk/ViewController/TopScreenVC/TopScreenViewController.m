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
#import "Tagcast/TGCTagcastManager.h"


@interface TopScreenViewController ()<TGCTagcastMangerDelegate>{
    BOOL isChecked;
    NSArray *_pickerData;
    NSString *viewStatus;
    UIImage *frameOpen, *frameBusy, *frameNormal, *frameUncheckin, *checkout, *checkin, *statusNormal, *statusOpen, *statusBusy, *statusInactive, *avatarDefault, *top_icon_checkin_off, *top_icon_checkin_on ;
    NSString *seatNumber ;
    NSMutableArray *dataTimer;
    NSTimer *timer;
    NSArray *sampleDataDesk, *serial_id_data;
    int ticker ;
    NSInteger *timeCheckout, *timeCheckin;
    CustomIOSAlertView *alertView;
    
}
@end

@implementation TopScreenViewController
@synthesize btnUserList, btnCheckIn, btnStatus, viewPicker, frameStatus, topView, lblId, lblEnglishName, lblJapaneseName, imgAvatar, imgIconCheckin;
//int const timeLimit = 57600;
int const timeLimit = 30;

- (void)viewDidLoad {
    [super viewDidLoad];
//    ticker = [[NSUserDefaults standardUserDefaults] integerForKey:@"seat1"];
    dataTimer = [[NSMutableArray alloc] init];
    sampleDataDesk = [NSArray arrayWithObjects:@"seat-1", @"seat-2", @"seat-3",@"seat-4", @"seat-5" ,nil];
    
    serial_id_data = [NSArray arrayWithObjects:@"JPN-PPER-0950-1797-7785", @"JPN-PPER-0758-3595-3603", nil];
    
    alertView = [[CustomIOSAlertView alloc] init];
    
    //seatNumber = [NSString stringWithFormat:@"seat-1"];
    //
    
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
    
//    lblJapaneseName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"jpName"];
//    lblEnglishName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"elName"];
//    lblId.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
//    NSString *img = [[NSUserDefaults standardUserDefaults] stringForKey:@"avatarUrl"];
//    if ([img isEqualToString:@""]){
//        imgAvatar.image = avatarDefault;
//    }
//    else {
//        imgAvatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img ]]];
//    }
    // set data demo
//    imgAvatar.image = avatarDefault;
    
    
    //
    SWRevealViewController *revealViewController = self.revealViewController;
    UITapGestureRecognizer *tap = [revealViewController tapGestureRecognizer];
    //tap.delegate = self;
    [topView addGestureRecognizer:tap];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
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
    viewPicker.frame = CGRectMake(0, 1000, 414, 200);
    
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
//    avatarDefault = [UIImage imageNamed:@"top_frame_default@3x.png"];
    avatarDefault = [UIImage imageNamed:@"avatar@3x.png"];
    //
    top_icon_checkin_on = [UIImage imageNamed:@"top_icon_checkin_on"];
    top_icon_checkin_off = [UIImage imageNamed:@"top_icon_checkin_off"];
    
//    // tagcast
    [[TGCTagcastManager sharedManager] setDelegate:self];
    [TGCTagcastManager provideAPIKey:@"e7ab7d225904673a3469f9a1a351a413"];
   
    isChecked = FALSE;
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
    viewPicker.frame = CGRectMake(0, 1000, 414, 200);
    [UIView commitAnimations];
    
    if ([viewStatus isEqualToString:@"オープン"]){
        [frameStatus setImage:frameOpen];
        [btnStatus setBackgroundImage:statusOpen forState:UIControlStateNormal];
    }
    else if ([viewStatus isEqualToString:@"ビジー"]){
        [frameStatus setImage:frameBusy];
        [btnStatus setBackgroundImage:statusBusy forState:UIControlStateNormal];
    }
    else {
        [frameStatus setImage:frameNormal];
        [btnStatus setBackgroundImage:statusNormal forState:UIControlStateNormal];
    }
}

- (IBAction)btnCancel:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    viewPicker.frame = CGRectMake(0, 1000, 414, 200);
    [UIView commitAnimations];
}

- (IBAction)changeStatus:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    int y_btnCheckin = btnCheckIn.frame.origin.y;
    int x = btnCheckIn.frame.size.height;
    viewPicker.frame = CGRectMake(0, y_btnCheckin - 200 + x, 414, 200);
    [UIView commitAnimations];
}

//[sender isSelected]
- (IBAction)checkIn:(id)sender {
    if ( isChecked == TRUE) {
        isChecked = FALSE;
        // checkout button
        [sender setBackgroundImage:checkin forState:UIControlStateNormal];
        [sender setSelected:NO];
        btnStatus.enabled = false;
        [frameStatus setImage:frameUncheckin];
        [btnStatus setBackgroundImage:statusInactive forState:UIControlStateNormal];
        [imgIconCheckin setImage:top_icon_checkin_off];
        _lblSeatNumber.text = @"チェックインしましょう";
        _lblSeatNumber.textColor = [UIColor darkGrayColor];
        //
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager POST:@"http://localhost:8080/linkdeskapi/api/reset-seat/" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//            NSLog(@"Reset seat done !");
//        } failure:^(NSURLSessionTask *operation, NSError *error) {
//            NSLog(@"reset fail");
//        }];
        
        //[timer invalidate];
        // get time checkout
        [[NSUserDefaults standardUserDefaults] setDouble:[self getTime] forKey:@"CheckoutTime"];

        NSLog(@"time in: %@, time out %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"CheckinTime"], [[NSUserDefaults standardUserDefaults] valueForKey:@"CheckoutTime"]);
        // get during time
        NSString *timeIn =[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckinTime"];
        NSString *timeOut =[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckoutTime"];
        NSInteger Time_in = [timeIn integerValue];
        NSInteger Time_out = [timeOut integerValue];
        NSInteger during_time = Time_out - Time_in;
        NSLog(@"during time: %d", Time_out - Time_in);
        
        // set NSUserDefaults for during time with seatNumber
        if ([[NSUserDefaults standardUserDefaults] valueForKey:seatNumber] != nil){
            NSString *oldTime = [[NSUserDefaults standardUserDefaults] valueForKey:seatNumber];
            NSInteger old_time = [oldTime integerValue];
            NSInteger new_time = during_time + old_time;
            [[NSUserDefaults standardUserDefaults] setInteger:new_time forKey:seatNumber];
        }
        else{
          [[NSUserDefaults standardUserDefaults] setInteger:during_time forKey:seatNumber];
        }
        if ([dataTimer containsObject:seatNumber]){
          //
        }
        else {
          [dataTimer addObject:seatNumber];
        }
        
        NSLog(@"value for seatNumber: %@",[[NSUserDefaults standardUserDefaults] valueForKey:seatNumber]);
    } else {
        // checkin button
        [[TGCTagcastManager sharedManager] startScan];
        
//        NSDictionary *tagcast_value = [[NSUserDefaults standardUserDefaults] valueForKey:@"current_tagcast"];
//        if (tagcast_value != nil){
//
////        NSString *spot = tagcast_value[kTGCKeySpotIdentifier];
////        NSString *entity = tagcast_value[kTGCKeyEntityNumber];
////        NSString *serial_id = tagcast_value[kTGCKeySerialIdentifier];
////        seatNumber = [NSString stringWithString:serial_id];
//
//        //get time checkin
//        [[NSUserDefaults standardUserDefaults] setInteger:[self getTime] forKey:@"CheckinTime"];
//        [[NSUserDefaults standardUserDefaults] setObject:dataTimer forKey:@"arrayDataDesk"];
//        //
//        [sender setBackgroundImage:checkout forState:UIControlStateSelected];
//        [sender setSelected:YES];
//        btnStatus.enabled = true;
//        [frameStatus setImage:frameNormal];
//        [btnStatus setBackgroundImage:statusNormal forState:UIControlStateNormal];
//        [imgIconCheckin setImage:top_icon_checkin_on];
//        //_lblSeatNumber.text = @"5F-1-21";
//        _lblSeatNumber.text = tagcast_value[kTGCKeyEntityNumber];
//        _lblSeatNumber.textColor = [UIColor greenColor];
//        isChecked = TRUE;
//        }
//        else
//            NSLog(@"Not Found !");
        
//        //random seatNumber data demo
//        uint32_t rnd = arc4random_uniform([sampleDataDesk count]);
//        seatNumber = [sampleDataDesk objectAtIndex:rnd];
//
//        ticker = [[NSUserDefaults standardUserDefaults] integerForKey:seatNumber];
//
//        if ([dataTimer containsObject:seatNumber]){
//            NSLog(@"da tung checkin");
//        }
//        else {
//            [dataTimer addObject:seatNumber];
//        }
//        NSLog(@"data timer count: %d", dataTimer.count);
        
        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        NSDictionary *params = @{@"seatNumber": seatNumber,
//                                 @"userNumber": [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"]};
//        [manager POST:@"http://localhost:8080/linkdeskapi/api/checkin/" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//            _lblSeatNumber.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
//            NSLog(@"return %@", responseObject);
//            NSLog(@"Checkin ok with seatNumber: %@, userID: %@", seatNmber, [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"] );
//        } failure:^(NSURLSessionTask *operation, NSError *error) {
//            NSLog(@"Checkin fail %@", error);
//        }];
    }
}
-(void)timer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
}
-(void)countTime{
    if (ticker == timeLimit){
        [timer invalidate];
        UIAlertView *alertTimeOver = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"Time over, please checkin in another desk !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertTimeOver show];
        NSLog(@"Time Over ! Please checkin in another desk");
    }
    else {
        ticker ++;
        NSLog(@"timer: %d, seatNumber: %@",ticker, seatNumber);
    }
}
-(int)getTime{
    NSDate *date = [NSDate date];
    NSInteger hour = 0;
    NSInteger minute = 0;
    NSInteger second = 0;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    [currentCalendar getHour:&hour minute:&minute second:&second nanosecond:NULL fromDate:date];
    NSInteger timeInSeconds = hour*3600 + minute*60 + second ;
    return timeInSeconds;
}
- (UIView *)createDialogView
{
    UIView *DialogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 343, 258)];
    DialogView.backgroundColor = [UIColor whiteColor];
    UIButton *btnOk = [[UIButton alloc] initWithFrame:CGRectMake(0, 209, 343, 50)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 258, 40)];
    UILabel *message1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 343, 50)];
    UILabel *message2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 343, 50)];
    UILabel *suggestDesk = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 343, 50)];
    [title setText:@"チェックインできませんでした"];
    [message1 setText:@"すでに利用頻度の高いデスクのようです。\nこちらのデスクはいかがですか？"];
    [message2 setText:@"※チェックインの履歴は毎月ごとにリセットされます。"];
    [title setFont:[UIFont boldSystemFontOfSize:17]];
    [message1 setFont:[UIFont systemFontOfSize:15]];
    [message2 setFont:[UIFont systemFontOfSize:15]];
    
    uint32_t rnd = arc4random_uniform([serial_id_data count]);
    NSString *randomDesk = [serial_id_data objectAtIndex:rnd];
//    [suggestDesk setText:@"「  」"];
    [suggestDesk setText:[NSString stringWithFormat:@"「 %@ 」", randomDesk]];
    
    message1.textAlignment = UITextAlignmentCenter ;
    suggestDesk.textAlignment = UITextAlignmentCenter ;
    message1.numberOfLines = 2;
    message2.numberOfLines = 2;
    title.numberOfLines = 2;
    [btnOk setBackgroundImage:[UIImage imageNamed:@"dialog_btn_close@3x.png"] forState:UIControlStateNormal];
    [btnOk setTitle:@"" forState:UIControlStateNormal];
    [btnOk addTarget:self
              action:@selector(btnOkAlertTap)
    forControlEvents:UIControlEventTouchUpInside];
    [DialogView addSubview:title];
    [DialogView addSubview:message1];
    [DialogView addSubview:message2];
    [DialogView addSubview:suggestDesk];
    [DialogView addSubview:btnOk];
    
    return DialogView;
}
-(void)btnOkAlertTap{
    [alertView close];
}
- (void)tagcastManager:(TGCTagcastManager *)manager didDiscoveredTagcast:(NSDictionary* )tagcast {
    NSDictionary *dict = nil;
    //    if(tagcasts.count) {
    dict = tagcast;
    
    NSString *spot = dict[kTGCKeySpotIdentifier];
    NSString *entity = dict[kTGCKeyEntityNumber];
    NSString *serial_id = [[dict objectForKey:@"data"] objectForKey:@"serial_id"];
    seatNumber = serial_id;
    
    NSLog(@"%s", serial_id);
    if ([serial_id_data containsObject:serial_id]){
        [[TGCTagcastManager sharedManager] stopScan];
        NSString *valueSeatNumber = [[NSUserDefaults standardUserDefaults] valueForKey:seatNumber];
        NSInteger valueSeatNumberInt = [valueSeatNumber integerValue];
        if ( valueSeatNumberInt > timeLimit){
            // Add some custom content to the alert view
            [alertView setContainerView:[self createDialogView]];
            
            // Modify the parameters
            [alertView setButtonTitles:NULL];
            [alertView setDelegate:self];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];
            isChecked = FALSE;
            NSLog(@"Time over %@", seatNumber);
        }
        else {
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"current_tagcast"];
            //get time checkin
            [[NSUserDefaults standardUserDefaults] setInteger:[self getTime] forKey:@"CheckinTime"];
            [[NSUserDefaults standardUserDefaults] setObject:dataTimer forKey:@"arrayDataDesk"];
            //
            [btnCheckIn setBackgroundImage:checkout forState:UIControlStateSelected];
            [btnCheckIn setSelected:YES];
            btnStatus.enabled = true;
            [frameStatus setImage:frameNormal];
            [btnStatus setBackgroundImage:statusNormal forState:UIControlStateNormal];
            [imgIconCheckin setImage:top_icon_checkin_on];
            //_lblSeatNumber.text = @"5F-1-21";
            _lblSeatNumber.text = entity;
            _lblSeatNumber.textColor = [UIColor greenColor];
            isChecked = TRUE;
        }
    }
    else {
        NSLog(@"Scan not success");
    }
    
    //    }
    //    else {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@“thong bao” message:@“scan fail” delegate:self cancelButtonTitle:@“ok” otherButtonTitles:@“ok”, nil];
    //    }
}
- (void)tagcastManager:(TGCTagcastManager *)manager didFailWithError:(NSError* )error {
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDialogView2]];

    // Modify the parameters
    [alertView setButtonTitles:NULL];
    [alertView setDelegate:self];

    [alertView setUseMotionEffects:true];

    // And launch the dialog
    [alertView show];
}
- (UIView *)createDialogView2
{
    UIView *DialogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 343, 258)];
    DialogView.backgroundColor = [UIColor whiteColor];
    UIButton *btnOk = [[UIButton alloc] initWithFrame:CGRectMake(0, 209, 343, 50)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 258, 40)];
    UILabel *message1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 258, 50)];
    UILabel *message2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 258, 100)];
    UILabel *suggestDesk = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 343, 50)];
    [title setText:@"チェックインできませんでした"];
    [message1 setText:@"再度、デスクのマークに置いて リトライしてください。"];
    [message2 setText:@"※Bluetoothをオンにしてください。他の機器とペアリングしている場合は、接続を解除してから再度お試しください。"];
    [title setFont:[UIFont boldSystemFontOfSize:17]];
    [message1 setFont:[UIFont systemFontOfSize:15]];
    [message2 setFont:[UIFont systemFontOfSize:15]];
    [suggestDesk setText:@""];
    
    message1.textAlignment = UITextAlignmentCenter ;
    message2.textAlignment = UITextAlignmentCenter ;
    suggestDesk.textAlignment = UITextAlignmentCenter ;
    message1.numberOfLines = 2;
    message2.numberOfLines = 4;
    title.numberOfLines = 2;
    [btnOk setBackgroundImage:[UIImage imageNamed:@"dialog_btn_close@3x.png"] forState:UIControlStateNormal];
    [btnOk setTitle:@"" forState:UIControlStateNormal];
    [btnOk addTarget:self
              action:@selector(btnOkAlertTap)
    forControlEvents:UIControlEventTouchUpInside];
    [DialogView addSubview:title];
    [DialogView addSubview:message1];
    [DialogView addSubview:message2];
    [DialogView addSubview:suggestDesk];
    [DialogView addSubview:btnOk];
    
    return DialogView;
}
@end

