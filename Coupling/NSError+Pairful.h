//
//  NSError+Pairful.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPFErrorCodeDomain	@"PFErrorCodeDomain"
#define kPFErrorTypeKeyName	@"PFErrorTypeKeyName"
#define kPFErrorCodeKeyName @"PFErrorCodeKeyName"
#define kPFMessageKeyName	@"PNMessageKeyName"

#define kPFConnectionError @"cannot_connect_to_server"

#define kPFPurchaseErrorProductNotFoundInTheAppStore @"product_not_found_in_the_app_store"
#define kPFPurchaseErrorMerchandiseNotFound @"merchandise_not_found"
#define kPFPurchaseErrorItemNotFound @"item_not_found"
#define kPFPurchaseErrorTransactionNotRestored @"transaction_not_restored"
#define kPFPurchaseErrorWillBeMaxedOut @"will_be_maxed_out"
#define kPFPurchaseErrorCannotMakePayments @"cannot_make_payments"
#define kPFPurchaseErrorPaymentFailed @"payment_failed"

#define kPFUIErrorCodeUpdateUnavailable @"update_unavailable"

typedef enum _kPFErrorCode {
	kPFErrorCodeNull			= 0x00000001 << 0,// dont use this from now on.
	kPFErrorCodeNetworkError	= 0x00000001 << 1,
	kPFErrorPairFailed			= 0x00000001 << 2,
	kPFErrorCodeCurrentlyUsed	= 0x00000001 << 3,
	kPFErrorCodeTimeout			= 0x00000001 << 4
} kPFErrorCode;

typedef enum _kPFErrorType {
	kPFErrorTypeDefaultError	= 0x00001000 << 0,
	kPFErrorTypeNetworkError	= 0x00001000 << 1
} kPFErrorType;

@interface NSError(Pairful)

- (int)errorType;
- (NSString *)errorCode;
- (NSString *)message;
- (NSError *)initWithResponse:(NSString *)response;
- (NSError *)initWithCode:(NSString *)code message:(NSString *)message;
+ (NSError *)errorWithType:(int)type message:(NSString*)message;
+ (NSError *)errorFromResponse:(NSString*)response;
+ (NSError *)errorWithCode:(NSString*)code message:(NSString*)message;

@end
