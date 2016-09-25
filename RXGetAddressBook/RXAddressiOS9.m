//
//  RXAddressiOS9.m
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXAddressiOS9.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface RXAddressiOS9 ()<ABPeoplePickerNavigationControllerDelegate>
{
    ABPeoplePickerNavigationController * _peoplePicker;
}
@end

@implementation RXAddressiOS9
- (void)getAddress:(id)controller {
    _peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    _peoplePicker.peoplePickerDelegate = self;
    [controller presentViewController:_peoplePicker animated:YES completion:nil];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    // >= iOS8
    
    [self getPeople:person property:property identifier:identifier];
    _peoplePicker = nil;
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person  {
    //NSLog(@"address9__person=%@", person);
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //< iOS8
    [self getPeople:person property:property identifier:identifier];
    
    [_peoplePicker dismissViewControllerAnimated:YES completion:nil];
    _peoplePicker = nil;
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    //NSLog(@"address9__取消");
    [_peoplePicker dismissViewControllerAnimated:YES completion:nil];
    _peoplePicker = nil;
}





- (void)getPeople:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    //获取名字全程
    NSString * fullName = (__bridge NSString *)(ABRecordCopyCompositeName(person));
    
    //用下面的 比较灵活
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
//    _nameLabel.text = nameStr;
    
    //NSLog(@"address9__person=%@==property=%d==identifier=%d", person, property, identifier);
    
    //获取电话号码
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    if(index >=0 ) {
        CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
        
        NSString * phoneString = (__bridge NSString *)telValue;
        phoneString = [phoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneString = [phoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
        BOOL status = YES;
        if(![self checkPhoneNum:phoneString]) {
            status = NO;
            //手机号不对
        }
        
        if(_complete) {
            _complete(YES, phoneString, fullName);
        }
    }
    else {
        //上面的if不判断，会崩溃，，例如点击联系人信息里的备注信息
        if(_complete) {
            _complete(NO, @"", fullName);
        }
    }
}

//是否为手机号码
- (BOOL)checkPhoneNum:(NSString *)str {
    NSString *regex = @"1[0-9]{10}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


@end
