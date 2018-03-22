/*
 *	@file TGCWebView.h
 *	@framework Tagcast
 *
 *  @discussion Entry point to the TAGCAST role for Web.
 *
 *	@copyright 2015 TAGCAST, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface TGCWebView : UIWebView

/*!
 *  @method tgcSharedWebViewWithAPIKey:frame:
 *
 *  @param apiKey       A NSString object.
 *  @param frame        TGCWebView object frame.
 *
 *  @discussion         API key registration, and will generate a TGC WebView singleton object.
 *
 */
+ (instancetype)tgcSharedWebViewWithAPIKey:(NSString *)apiKey frame:(CGRect)frame;

@end
