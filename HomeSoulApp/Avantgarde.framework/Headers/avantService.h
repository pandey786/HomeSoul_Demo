//
//  avantgarde.h
//  avantgarde
//
//  Created by Pramod Yadav on 05/01/18.
//  Copyright © 2018 SafexPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol avantServiceDelegate <NSObject>
-(void)TransactionResponse:(NSString *)status;
@end
@interface avantService : NSObject{
    
}
+ (avantService *)sharedController;
-(void)SetData:(NSString *) Merchant_Key :(NSString *)Merchant_ID :(NSString *) SuccessUrl_Key :(NSString *) FailureUrl_Key;

-(BOOL)Transactiondata:(NSString *)Transaction_Detail :(NSString *)Payment_Details :(NSString*)Card_Detail :(NSString *)Customer_Detail :(NSString *)Bill_data :(NSString *)Ship_details :(NSString *)Item_Detail :(NSString *)Other_Detail :(NSString *)Coin_Detail :(NSString *)Upi_Detail :(NSString *)Imps_Detail;

-(void) showTransactionPageViewController:(UIViewController *)viewController;

@property (nonatomic,retain) id <avantServiceDelegate> delegate;
@end
