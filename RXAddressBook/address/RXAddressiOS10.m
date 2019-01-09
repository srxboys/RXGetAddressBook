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
        [self.delegate addressBookComplete:RXNULLSTR(phoneString) nameString:RXNULLSTR(nameString)];
    }
    
    NSDictionary * addressDict = nil;
    if([contactProperty.value isKindOfClass:[CNPostalAddress class]]) {
        //key == postalAddresses;
        CNPostalAddress * address = (CNPostalAddress *)contactProperty.value;
        if(address) {
            NSMutableDictionary * newDict = [[NSMutableDictionary alloc] init];
            [newDict setObject:RXNULLSTR(address.street) forKey:@"street"];
            [newDict setObject:RXNULLSTR(address.city) forKey:@"city"];
            [newDict setObject:RXNULLSTR(address.state) forKey:@"state"];
            [newDict setObject:RXNULLSTR(address.country) forKey:@"country"];
            [newDict setObject:RXNULLSTR(address.ISOCountryCode) forKey:@"countryCode"];
            [newDict setObject:RXNULLSTR(address.postalCode) forKey:@"postalCode"];
            [newDict setObject:RXNULLSTR(@"") forKey:@"formattedAddress"];
            
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
                                  RX_AD_K_FULLNAME:RXNULLSTR(nameString),
                                  RX_AD_K_NAME:RXNULLSTR(givenName),
                                  RX_AD_K_SURNMAE:RXNULLSTR(familyName),
                                  RX_AD_K_COMPANY:RXNULLSTR(company),
                                  RX_AD_K_PHONE:RXNULLSTR(phoneString),
                                  RX_AD_K_ADDRESS:RXNULLSTR(addressDict),
                                  RX_AD_K_URL:RXNULLSTR(url),
                                  RX_AD_K_EIMAIL:RXNULLSTR(email),
                                  RX_AD_K_IMAGE:RXNULLOBJ(image),
                                  RX_AD_K_NOTE:RXNULLSTR(note)
                                  };
    if([self.delegate respondsToSelector:@selector(addressBookComplete:)]){
        [self.delegate addressBookComplete:allDiction];
    }
}


//取消选择回调
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
