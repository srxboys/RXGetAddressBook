//
//  RXAddressiOS10.m
//  RXGetAddressBook
//
//  Created by srx on 16/9/25.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXAddressiOS10.h"

#import <ContactsUI/ContactsUI.h>
//库的名称->修改required为optional

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
    
    NSString * nameString = @"";
    
    
    
    NSString * familyName = contactProperty.contact.familyName;
    NSString * givenName  = contactProperty.contact.givenName;
    
    
    if(familyName) {
        nameString = [nameString stringByAppendingString:familyName];
    }
    if(givenName) {
        nameString = [nameString stringByAppendingString:givenName];
    }
    
    NSString * phoneString = nil;
    if([contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        //key == phoneNumbers;
        phoneString = [contactProperty.value stringValue];
    }

    
    if([self.delegate respondsToSelector:@selector(addressBookComplete:nameString:)]) {
        [self.delegate addressBookComplete:RX_NULL_STR(phoneString) nameString:RX_NULL_STR(nameString)];
    }
    
    if([self.delegate respondsToSelector:@selector(addressBookComplete:)]){
    
        NSDictionary * addressDict = nil;
        if([contactProperty.value isKindOfClass:[CNPostalAddress class]]) {
            //key == postalAddresses;
            CNPostalAddress * address = (CNPostalAddress *)contactProperty.value;
            if(address) {
                NSMutableDictionary * newDict = [[NSMutableDictionary alloc] init];
                [newDict setObject:RX_NULL_STR(address.street) forKey:@"street"];
                [newDict setObject:RX_NULL_STR(address.city) forKey:@"city"];
                [newDict setObject:RX_NULL_STR(address.state) forKey:@"state"];
                [newDict setObject:RX_NULL_STR(address.country) forKey:@"country"];
                [newDict setObject:RX_NULL_STR(address.ISOCountryCode) forKey:@"countryCode"];
                [newDict setObject:RX_NULL_STR(address.postalCode) forKey:@"postalCode"];
                [newDict setObject:RX_NULL_STR(@"") forKey:@"formattedAddress"];
                
                addressDict = newDict;
            }
        }
        
        NSString * company = contactProperty.contact.organizationName;
        
        NSData * image = nil;
        @try {
            //contactProperty.contact.imageData; //太大了
            image = contactProperty.contact.thumbnailImageData; ///缩略图
        } @catch (NSException *exception) {
    #if DEBUG
            NSLog(@"image exception= %@", exception.description);
    #endif
        }
        NSString * note = nil;
        @try {
            note = contactProperty.contact.note;
            if(![note isKindOfClass:[NSString class]]) note = nil;
            NSLog(@"note=%@", note);
        } @catch (NSException *exception) {
    #if DEBUG
            NSLog(@"note exception= %@", exception.description);
    #endif
        }
        
        NSString * url = nil;
        NSString * email = nil;
        
        if([contactProperty.value isKindOfClass:[NSString class]]) {
            if([contactProperty.key isEqualToString:@"urlAddresses"]) {
                url = contactProperty.value;
            }
            else if([contactProperty.key isEqualToString:@"emailAddresses"]) {
                email = contactProperty.value;
            }
        }
        
        NSString * partment = nil;
        if([contactProperty.value isKindOfClass:[CNContactRelation class]]) {
            CNContactRelation * releation = contactProperty.value;
            partment = releation.name;
        }
        
        NSDictionary * allDiction = @{
                                      RX_AD_K_FULLNAME:RX_NULL_STR(nameString),
                                      RX_AD_K_NAME:RX_NULL_STR(givenName),
                                      RX_AD_K_SURNMAE:RX_NULL_STR(familyName),
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


//取消选择回调
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
