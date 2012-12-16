//
//  MyStoreObserver.m
//  Coupling
//
//  Created by tsuchimoto on 12/09/17.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "MyStoreObserver.h"

@implementation MyStoreObserver


#pragma mark -

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                [self startingTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        // Count down
        @synchronized(self) {
            NSInteger numOfTransaction = [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfTransactions"];
            [[NSUserDefaults standardUserDefaults] setInteger:numOfTransaction-1 forKey:@"NumberOfTransactions"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (void)startingTransaction:(SKPaymentTransaction *)transaction
{
    // Count up
    @synchronized(self) {
        NSInteger numOfTransaction = [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfTransactions"];
        [[NSUserDefaults standardUserDefaults] setInteger:numOfTransaction + 1 forKey:@"NumberOfTransactions"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    NSInteger numOfTransaction = [[NSUserDefaults standardUserDefaults] integerForKey:@"NumberOfTransactions"];
    NSInteger code = transaction.error.code;
    
    if (code == SKErrorPaymentCancelled && numOfTransaction == 1) {
        [self showAlert:@"購入がキャンセルされました"];
    } else {
        switch (transaction.error.code) {
            case SKErrorUnknown:
                [self showAlert:@"未知のエラーが発生しました"];
                break;
            case SKErrorClientInvalid:
                [self showAlert:@"不正なクライアントです"];
                break;
            case SKErrorPaymentCancelled:
                [self showAlert:@"購入がキャンセルされました"];
                break;
            case SKErrorPaymentInvalid:
                [self showAlert:@"不正な購入です"];
                break;
            case SKErrorPaymentNotAllowed:
                [self showAlert:@"購入が許可されていません"];
                break;
            default:
                [self showAlert:transaction.error.localizedDescription];
                break;
        }
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
//    NSData *receipt = transaction.transactionReceipt;
    
}

- (void)provideContent:(NSString *)productIdentifier
{
    //[self showAlert:[NSString stringWithFormat:@"購入が完了しました %@", productIdentifier]];
}

@end
