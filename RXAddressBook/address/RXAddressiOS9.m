//
//  RXAddressiOS9.m
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXAddressiOS9.h"

#import <AddressBookUI/AddressBookUI.h>
//库的名称->修改required为optional

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
    NSString * phoneString = nil;
    //获取电话号码
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    if(index >=0 ) {
        CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
        phoneString = (__bridge NSString *)telValue;
    }
    
    if([self.delegate respondsToSelector:@selector(addressBookComplete:nameString:)]) {
        [self.delegate addressBookComplete:RX_NULL_STR(phoneString) nameString:RX_NULL_STR(nameStr)];
    }
    
    if([self.delegate respondsToSelector:@selector(addressBookComplete:)]){
    
        NSDictionary * addressDict = nil;
        valuesRef = [self getMultiValueWith:person property:kABPersonAddressProperty identifier:identifier];
        if(valuesRef) {
            addressDict = (__bridge NSDictionary *)valuesRef;
            
            NSMutableDictionary * newDict = [[NSMutableDictionary alloc] init];
            [newDict setObject:RX_NULL_STR(addressDict[@"Street"]) forKey:@"street"];
            [newDict setObject:RX_NULL_STR(addressDict[@"City"]) forKey:@"city"];
            [newDict setObject:RX_NULL_STR(addressDict[@"State"]) forKey:@"state"];
            [newDict setObject:RX_NULL_STR(addressDict[@"Country"]) forKey:@"country"];
            [newDict setObject:RX_NULL_STR(addressDict[@"CountryCode"]) forKey:@"countryCode"];
            [newDict setObject:RX_NULL_STR(addressDict[@""]) forKey:@"postalCode"];
            [newDict setObject:RX_NULL_STR(addressDict[@""]) forKey:@"formattedAddress"];
            addressDict = newDict;
        }
        
        NSString * company = nil;
        valuesRef = ABRecordCopyValue(person, kABPersonOrganizationProperty);
        if(valuesRef) {
            company = (__bridge NSString *)valuesRef;
        }
        
        NSData * image = nil;
        if(ABPersonHasImageData(person)) {
            CFDataRef dataRef = ABPersonCopyImageData(person);
            if(dataRef) {
                image = (__bridge NSData*)dataRef;
            }
        }

        NSString * email = nil;
        valuesRef = [self getMultiValueWith:person property:kABPersonEmailProperty identifier:identifier];
        if(valuesRef) {
            email  = (__bridge NSString *)valuesRef;
        }
        
        NSString * url = nil;
        valuesRef = ABRecordCopyValue(person, kABPersonURLProperty);
        if(valuesRef) {
            url  = (__bridge NSString *)valuesRef;
        }
        
        
        NSString * note = CFBridgingRelease(ABRecordCopyValue(person, kABPersonNoteProperty));
        
    //    NSString * partment = CFBridgingRelease(ABRecordCopyValue(person, kABPersonDepartmentProperty));
        
        NSDictionary * allDiction = @{
                                      RX_AD_K_FULLNAME:RX_NULL_STR(fullName),
                                      RX_AD_K_NAME:RX_NULL_STR(firstName),
                                      RX_AD_K_SURNMAE:RX_NULL_STR(lastname),
                                      RX_AD_K_COMPANY:RX_NULL_STR(company),
                                      RX_AD_K_PHONE:RX_NULL_STR(phoneString),
                                      RX_AD_K_ADDRESS:RX_NULL_DIC(addressDict),
                                      RX_AD_K_URL:RX_NULL_STR(url),
                                      RX_AD_K_EIMAIL:RX_NULL_STR(email),
                                      RX_AD_K_IMAGE:RX_NULL_OBJ(image),
                                      RX_AD_K_NOTE:RX_NULL_STR(note)
                                      };
    
        [self.delegate addressBookComplete:allDiction];
    }
}

// 根据 API 定义，有多值，可以用这个处理
- (CFStringRef)getMultiValueWith:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    CFTypeRef objcRef = ABRecordCopyValue(person, property);
    if(!objcRef) return 0x0;
    CFIndex index = ABMultiValueGetIndexForIdentifier(objcRef, identifier);
    if(index >= 0) {
        return ABMultiValueCopyValueAtIndex(objcRef,index);
    }
    return nil;
}

@end
