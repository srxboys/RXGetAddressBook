//
//  ViewController.m
//  RXGetAddressBook
//
//  Created by srx on 16/4/21.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "ViewController.h"
#import "RXAddressBook.h"

@interface ViewController ()<RXAddressBookDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
- (IBAction)getAddressBookButtonClick:(id)sender;


@property (nonatomic, strong) RXAddressBook * addressBook;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addressBook = [[RXAddressBook alloc] init];
    _addressBook.delegate = self;
}

- (IBAction)getAddressBookButtonClick:(id)sender {
    [self.addressBook getAddressBookInController:self];
}

- (void)addressBookComplete:(NSString *)phoneString nameString:(NSString *)nameString {
    NSString * phone = [RXAddressBook formatPhoneString:RXNULLSTR(phoneString)];
    NSLog(@"phone=%@", phone);
//    if([RXAddressBook checkPhoneString:phone]) {
//        self.phoneLabel.text = phoneString;
//    }
    self.phoneLabel.text = RXNULLSTR(phoneString);
    self.nameLabel.text = RXNULLSTR(nameString);
}

- (void)addressBookComplete:(NSDictionary *)allDataSource {
    //点击了哪里，哪里的数据返回
//    NSLog(@"%@", allDataSource);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
