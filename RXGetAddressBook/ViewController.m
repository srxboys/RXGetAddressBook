//
//  ViewController.m
//  RXGetAddressBook
//
//  Created by srx on 16/4/21.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "ViewController.h"

#define SYSTEMVERSION   [UIDevice currentDevice].systemVersion
#define iOS9Later ([SYSTEMVERSION floatValue] >= 9.0)

#import "RXAddressiOS10.h"
#import "RXAddressiOS9.h"


@interface ViewController () {
    RXAddressiOS9 * _objct9;
    RXAddressiOS10 * _objct10;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
- (IBAction)getAddressBookButtonClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    
    _objct10 = [[RXAddressiOS10 alloc] init];
    _objct10.complete = ^(BOOL status, NSString * phoneNum, NSString * nameString) {
        if(status) {
            weakSelf.phoneLabel.text = phoneNum;
        }
        
        weakSelf.nameLabel.text = nameString;
    };
    _objct9 = [[RXAddressiOS9 alloc] init];
    _objct9.complete = ^(BOOL status, NSString * phoneNum, NSString * nameString) {
        if(status) {
            weakSelf.phoneLabel.text = phoneNum;
        }
        weakSelf.nameLabel.text = nameString;
    };
}

- (IBAction)getAddressBookButtonClick:(id)sender {
    if(iOS9Later) {
        
        [_objct10 getAddress:self];
    }
    else {
        
        [_objct9 getAddress:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
