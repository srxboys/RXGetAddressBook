//
//  RXAddressBook.m
//  RXGetAddressBook
//
//  Created by srxboys on 2018/12/13.
//  Copyright © 2018 srxboys. All rights reserved.
//

#import "RXAddressBook.h"

#import "RXAdrObj.h"
#import "RXAddressiOS9.h"
#import "RXAddressiOS10.h"

#define RX_A_SYSTEMVERSION   [UIDevice currentDevice].systemVersion
#define RX_A_iOS9OrLater ([RX_A_SYSTEMVERSION floatValue] >= 9.0)


NSString * const RX_AD_K_FULLNAME = @"R_X_K_fullName"; ///< 全名            (Type = NSString)
NSString * const RX_AD_K_NAME     = @"R_X_K_name";     ///< 名字            (Type = NSString)
NSString * const RX_AD_K_SURNMAE = @"R_X_K_surname";   ///< 姓氏            (Type = NSString)
NSString * const RX_AD_K_COMPANY = @"R_X_K_company";   ///< 公司            (Type = NSString)
NSString * const RX_AD_K_PHONE   = @"R_X_K_phone";     ///< 手机号          (Type = NSString)
NSString * const RX_AD_K_ADDRESS = @"R_X_K_address";   ///< 地址            (Type = NSString)
NSString * const RX_AD_K_URL     = @"R_X_K_url";;      ///< urlAddresses   (Type = NSString)
NSString * const RX_AD_K_EIMAIL  = @"R_X_K_email";     ///< emailAddresses (Type = NSString)
NSString * const RX_AD_K_IMAGE   = @"R_X_K_image";     ///< imageData      (Type = NSData)
NSString * const RX_AD_K_NOTE    = @"R_X_K_note";      ///< 备注            (Type = NSString)

@interface RXAddressBook ()<RXAddressBookDelegate>
@property (nonatomic, strong) id<RXAdrObj> addressBook;
@end

@implementation RXAddressBook

- (instancetype)init
{
    self = [super init];
    if (self) {
        Class adObjClass = nil;
        if(RX_A_iOS9OrLater) {
            adObjClass = RXAddressiOS10.class;
        }
        else {
            adObjClass = RXAddressiOS9.class;
        }
        id<RXAdrObj> address = [[adObjClass alloc] init];
        address.delegate = self;
        _addressBook = address;
    }
    return self;
}

- (void)getAddressBookInController:(id)controller {
    [self.addressBook getAddress:controller];
}

- (void)addressBookComplete:(NSString *)phoneString nameString:(NSString *)nameString {
    __strong typeof(_delegate) strongDelegate = _delegate;
    if([strongDelegate respondsToSelector:@selector(addressBookComplete:nameString:)]) {
        [strongDelegate addressBookComplete:phoneString nameString:nameString];
    }
}

- (void)addressBookComplete:(NSDictionary *)allDataSource {
    __strong typeof(_delegate) strongDelegate = _delegate;
    if([strongDelegate respondsToSelector:@selector(addressBookComplete:)]) {
        [strongDelegate addressBookComplete:allDataSource];
    }
}


//是否为手机号码
+ (BOOL)checkPhoneString:(NSString *)phoneString {
    NSString *regex = @"1[0-9]{10}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneString];
    return isMatch;
}

+ (NSString *)formatPhoneString:(NSString *)phontString {
    if(!phontString) return @"";
    NSInteger lenght = phontString.length;
    NSString * phone = @"";
    for(NSInteger i = 0; i < lenght; i++) {
        NSString * charS = [phontString substringWithRange:NSMakeRange(i, 1)];
        char c = charS.UTF8String[0];
        if(c >= '0' && c <= '9') {
            phone = [phone stringByAppendingString:charS];
        }
    }
    return phone;
}

@end
