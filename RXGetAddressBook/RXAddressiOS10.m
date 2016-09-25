//
//  RXAddressiOS10.m
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXAddressiOS10.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface RXAddressiOS10 ()<CNContactPickerDelegate>

@end

@implementation RXAddressiOS10
- (void)getAddress:(id)controller {
    CNContactPickerViewController * contactVc = [[CNContactPickerViewController alloc] init];
    contactVc.delegate = self;
    [controller presentViewController:contactVc animated:YES completion:^{
        
    }];
    
}


//选择完成代理回调

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
        //NSLog(@"address10_@@@_name:%@%@",contactProperty.contact.familyName, contactProperty.contact.givenName);
    
    NSString * nameString = contactProperty.contact.familyName;
    nameString = [nameString stringByAppendingString:contactProperty.contact.givenName];
    
    if([contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
//        //NSLog(@"address10_@@@_phone:%@",[contactProperty.value  stringValue]);
        NSString * phoneString = [contactProperty.value stringValue];
        phoneString = [phoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneString = [phoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
        BOOL status = YES;
        if(![self checkPhoneNum:phoneString]) {
            status = NO;
            //手机号不对
        }
        
        if(_complete) {
            _complete(YES, phoneString, nameString);
        }
    }
    else {
        //NSLog(@"上面的if不判断，会崩溃，，例如点击联系人信息里的备注信息");
        if(_complete) {
            _complete(NO, @"", nameString);
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


//取消选择回调
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
