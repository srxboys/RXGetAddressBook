//
//  ViewController.m
//  RXGetAddressBook
//
//  Created by srx on 16/4/21.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "ViewController.h"

//#if __IPHONE_9_0
//    #import <Contacts/Contacts.h>
//    #import <ContactsUI/ContactsUI.h>
//#else
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
//#endif

@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate>
{
    ABPeoplePickerNavigationController * _peoplePicker;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
- (IBAction)getAddressBookButtonClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    _peoplePicker.peoplePickerDelegate = self;
}

- (IBAction)getAddressBookButtonClick:(id)sender {
    
    [self presentViewController:_peoplePicker animated:YES completion:nil];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    // >= iOS8
    
    [self getPeople:person property:property identifier:identifier];
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person  {
    NSLog(@"person=%@", person);
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //< iOS8
    [self getPeople:person property:property identifier:identifier];
    
    [_peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    NSLog(@"取消");
    [_peoplePicker dismissViewControllerAnimated:YES completion:nil];
}












- (void)getPeople:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    NSString * nameStr = nil;
    //名字获取
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
     NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *middlename = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    
    if(firstName != nil) {
        nameStr = firstName;
    }
    else if(lastname != nil) {
        nameStr = lastname;
    }
    else {
        nameStr = middlename;
    }
    _nameLabel.text = nameStr;
    
    NSLog(@"person=%@==property=%d==identifier=%d", person, property, identifier);
    
    //获取电话号码
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    NSString * phoneString = (__bridge NSString *)telValue;
    phoneString = [phoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    [self showPhoneNumLabel:phoneString];
}

- (void)showPhoneNumLabel:(NSString *)string {
    if(![self checkPhoneNum:string]) {
        NSLog(@"不是11位手机号");
    }
    
    _phoneLabel.text = string;
}


//是否为手机号码
- (BOOL)checkPhoneNum:(NSString *)str {
    NSString *regex = @"1[0-9]{10}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
