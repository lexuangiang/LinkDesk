/*
 *	@file TGCTagcastManager.h
 *	@framework Tagcast
 *
 *  @discussion Entry point to the TAGCAST role.
 *
 *	@copyright TAGCAST, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

/*!
 *  @const kTGCErrorDomain
 *
 *  @discussion TGCTagcastManager error domain name.
 *
 *  @see TGCErrorCode
 *
 */
extern NSString * const kTGCErrorDomain;

/*!
 *  Represents the error code of a TGCTagcastManager.
 */
typedef NS_ENUM(NSInteger, TGCErrorCode) {
    /// System error.
    TGCErrorCodeUnknown = -1,
    /// Database error.
    TGCErrorCodeDatabase,
    /// Network error.
    TGCErrorCodeNetwork,
    /// Bluetooth error.
    TGCErrorCodeBluetooth,
    /// SDK management data do not exist.
    TGCErrorCodeMasterDataNotExists __attribute__((deprecated("Not return this enum."))),
    /// Debug data unavailable.
    TGCErrorCodeDebugDataInvalid,
    /// API key unavailable.
    TGCErrorCodeAPIKeyNotRegistered,
    /// Invalid scan interval value.
    TGCErrorCodeInvalidScanInterval,
    /// SDK management data failed to update.
    TGCErrorCodeMasterDataFailedUpdate,
    /// This value is deprecated, but was equivalent to the new -DataNotExists value.
    TGCErrorCodeTagcastDataNotExists __attribute__((deprecated("Please use \"TGCErrorCodeMasterDataNotExists\" instead."))) = TGCErrorCodeMasterDataNotExists,
};

/*!
 *  @const kTGCKeySpotIdentifier
 *  @discussion The string representation of the TAGCAST for the spot identifier descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeySpotIdentifier;

/*!
 *  @const kTGCKeySerialIdentifier
 *  @discussion Available in SDK 1.0.7 and later.
 *              The string representation of the TAGCAST for the serial identifier descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeySerialIdentifier;

/*!
 *  @const kTGCKeySpotSequenceNumber
 *  @discussion Obsoleted in SDK 1.0.3.
 *              The string representation of the TAGCAST for the spot sequence number descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeySpotSequenceNumber __attribute__((unavailable("obsoleted in SDK 1.0.3. Please use \"kTGCKeyEntityNumber\" instead.")));

/*!
 *  @const kTGCKeyEntityNumber
 *  @discussion Available in SDK 1.0.3 and later.
 *              The string representation of the TAGCAST for the spot entity number descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyEntityNumber;

/*!
 *  @const kTGCKeyData
 *  @discussion The string representation of the TAGCAST for the detailed information descriptor.
 *				The corresponding value for this descriptor is an <code>NSDictionary</code> object.
 */
extern NSString * const kTGCKeyData;

/*!
 *  @const kTGCKeyDistanceLevel
 *  @discussion The string representation of the TAGCAST for the <code>TGCDistanceLevel</code> descriptor.
 *				The corresponding value for this descriptor is an <code>NSNumber</code> object.
 */
extern NSString * const kTGCKeyDistanceLevel;

/*!
 *  @const kTGCKeyType
 *  @discussion Available in SDK 1.1.3 and later.
 *              The string representation of the TAGCAST for the beacon type <code>TGCType</code> descriptor.
 *				The corresponding value for this descriptor is an <code>NSNumber</code> object.
 */
extern NSString * const kTGCKeyType;

/*!
 *  @const kTGCKeyLatitude
 *  @discussion The string representation of the TAGCAST for the latitude descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyLatitude;

/*!
 *  @const kTGCKeyLongitude
 *  @discussion The string representation of the TAGCAST for the longitude descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyLongitude;

/*!
 *  @const kTGCKeyPlaceName
 *  @discussion The string representation of the TAGCAST for the place name descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyPlaceName;

/*!
 *  @const kTGCKeyState
 *  @discussion The string representation of the TAGCAST for the state descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyState;

/*!
 *  @const kTGCKeyCity
 *  @discussion The string representation of the TAGCAST for the city descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyCity;

/*!
 *  @const kTGCKeyAddress1
 *  @discussion The string representation of the TAGCAST for the address1 descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyAddress1;

/*!
 *  @const kTGCKeyAddress2
 *  @discussion The string representation of the TAGCAST for the address2 descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyAddress2;

/*!
 *  @const kTGCKeyFloor
 *  @discussion The string representation of the TAGCAST for the floor level descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeyFloor;

/*!
 *  @const kTGCKeySpotURL
 *  @discussion Available in SDK 1.1.9 and later.
 *              The string representation of the TAGCAST for the spot URL string descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeySpotURL;

/*!
 *  @const kTGCKeySpotGroupIdentifier
 *  @discussion Available in SDK 2.0.3 and later.
 *              The string representation of the TAGCAST for the spot group identifier string descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeySpotGroupIdentifier;

/*!
 *  @const kTGCKeySpotGroupName
 *  @discussion Available in SDK 2.0.3 and later.
 *              The string representation of the TAGCAST for the spot group name string descriptor.
 *				The corresponding value for this descriptor is an <code>NSString</code> object.
 */
extern NSString * const kTGCKeySpotGroupName;

/*!
 *  @const kTGCDefaultScanInterval
 *  @discussion Default scan interval time(3.0sec).
 */
extern const NSTimeInterval kTGCDefaultScanInterval;

/*!
 *  @const kTGCDefaultAutoMasterUpdateInterval
 *  @discussion Default auto master update interval time(6hour).
 */
extern const NSInteger kTGCDefaultAutoMasterUpdateInterval;

/*!
 *  Represents state of a TGCTagcastManager.
 */
typedef NS_ENUM(NSInteger, TGCTagcastManagerState) {
    /// Manager is stopped completely, including the Bluetooth.
    TGCTagcastManagerStateStopped,
    /// Manager has stopped, leaving the scan data.
    TGCTagcastManagerStateSuspend,
    /// In the preparing, it starts as soon as the end.
    TGCTagcastManagerStateWaiting,
    /// Scan of TAGCAST is running.
    TGCTagcastManagerStateStarting,
    /// Preparation during operation.
    TGCTagcastManagerStatePreparing,
    /// Preparation operation is complete. Manager can start the scan.
    TGCTagcastManagerStatePrepared,
    /// Running the maintenance.
    TGCTagcastManagerStateMaintenance,
};


/*!
 *  Approximate location of the received TAGCAST.
 */
typedef NS_ENUM(NSInteger, TGCDistanceLevel) {
    /// Unknown distance.
    TGCDistanceLevelUnknown,
    /// Proximity.
    TGCDistanceLevelProximity,
    /// Short distance "about 1 meters or less".
    TGCDistanceLevelShort,
    /// Middle distance "about 10 meters".
    TGCDistanceLevelMiddle,
    /// Long distance "about 10 meters or more ※ maximum Approx. 50 meters".
    TGCDistanceLevelLong,
};

/*!
 *  Available in SDK 1.1.3 and later. Represent TAGCAST type.
 */
typedef NS_ENUM(NSInteger, TGCType) {
    /// Small TAGCAST beacon.
    TGCTypeNormalBeacon,
    /// Surface authentication beacons that can identify tables.
    TGCTypePaperBeacon,
    /// Fusion products of light and beacon.
    TGCTypeLEDBeacon,
    /// Sensor Beacon.
    TGCTypeSensorBeacon,
};

@protocol TGCTagcastMangerDelegate;

/*!
 *  @class TGCTagcastManager
 *
 *  @discussion Entry point to the TAGCAST role. Commands should only be issued when its state is CBCentralManagerStatePoweredOn.
 *
 *  @see CBCentralManagerState
 *
 */
@interface TGCTagcastManager : NSObject

/*!
 *  @property delegate
 *
 *  @discussion The delegate object that will receive TAGCAST events.
 *
 */
@property (nonatomic, weak) id<TGCTagcastMangerDelegate> delegate;

/*!
 *  @property scanInterval
 *
 *  @disucussion Scan timer interval(seconds). Set between 1 to 60 seconds. tagcastManager:didDiscoverdTagcast: delegate method is called with this value.
 *
 */
@property (nonatomic, assign) NSTimeInterval scanInterval;

/*!
 *  @property state
 *
 *  @discussion The current state of the TGCTagcastManager, initially set to TGCTagcastManagerStateStopped.
 *              Updates are provided by delegate method tagcastManager:didChangeState: .
 *
 */
@property (nonatomic, assign, readonly) TGCTagcastManagerState state;

/*!
 *  @property debug
 *
 *  @discussion Return 'YES' if called startDebugScan method.
 *
 */
@property (nonatomic, assign, readonly) BOOL debug;

/*!
 *  @property autoMasterUpdateInterval
 *
 *  @disucussion Auto Master Update timer interval(hour). Set between 0 to 24 hour.
 *               It will not update automatically if you set under 0 hours, It will set as 24 hours if you set over 25 hours.
 *
 */
@property (nonatomic, assign) NSInteger autoMasterUpdateInterval;

/*!
 *  @method sharedManager
 *
 *  @discussion Return the singleton object of TGCTagcastManager.
 *
 *  @return TGCTagcastManager singleton instance.
 *
 */
+ (TGCTagcastManager *)sharedManager;

/*!
 *  @method provideAPIKey:
 *
 *  @param APIKey A NSString object.
 *
 *  @discussion This key is generated for your application via the TAGCAST Developer Console,
 *              and is paired with your application's bundle identifier to identify it.
 *              This method should be called exactly once by your application,
 *              and will also initialized at the same time.
 *
 *  @return As a result of checking the character string pattern.
 *
 */
+ (BOOL)provideAPIKey:(NSString *)APIKey;

/*!
 *  @method SDKVersion
 *
 *  @discussion The version for this release of TAGCAST-SDK.
 *
 *  @return TAGCAST-SDK version string.
 *
 */
+ (NSString *)SDKVersion;

/*!
 *  @method prepare
 *
 *  @discussion Preparatory operations such as updating of the TAGCAST data, and state changes to TGCTagcastManagerStatePreparing.
 *              State changes to TGCTagcastManagerStatePrepared to be completed.
 *              Referred to at the start of the scan could be called in advance is recommended.
 *              When the provideAPIKey: method is executing, this is called at the same time.
 *
 */
- (void)prepare;

/*!
 *  @method startScan
 *
 *  @discussion Will start scanning TAGCASTs of peripheral, and state changes to TGCTagcastManagerStateStarting.
 *              In the case of preparation during operation, and wait for it to end. also state changes to TGCTagcastManagerStateWaiting.
 *
 */
- (void)startScan;

/*!
 *  @method startDebugScan
 *
 *  @discussion Will start scanning TAGCASTs in debug mode, and receive the debug data every second.
 *              State changes to TGCTagcastManagerStateStarting and debug property is to YES.
 *
 *  @see debug
 *
 */
- (void)startDebugScan;

/*!
 *  @method stopScan
 *
 *  @discussion Finish the receiving operation of TAGCASTs, and state changes to TGCTagcastManagerStateStopped.
 *
 */
- (void)stopScan;

/*!
 *  @method tagcastDataMaintenance
 *
 *  @discussion Will do the update of the TAGCAST data and state changes to TGCTagcastManagerStateMaintenance.
 *
 */
- (void)tagcastDataMaintenance;

/*!
 *  @method requestTagcastUUID:completion:
 *
 *  @discussion Request TAGCAST-UUID String.
 *
 */
- (void)requestTagcastUUID:(NSString *)APIKey completion:(void (^)(NSString *tagcastUUID, NSError *error))completion;

@end

/*!
 *  @protocol TGCTagcastMangerDelegate
 *
 *  @discussion The delegate of a TGCTagcastManager object must adopt the TGCTagcastMangerDelegate protocol.
 */
@protocol TGCTagcastMangerDelegate <NSObject>

@optional

/*!
 *  @method tagcastManager:didChangeState:
 *
 *  @param manager      TGCTagcastManager providing this information.
 *  @param state        State of the current TAGCAST manager.
 *
 *  @discussion         This method is invoked when the state of the manager has changed.
 *
 *  @see                TGCTagcastManagerState
 *
 */
- (void)tagcastManager:(TGCTagcastManager *)manager didChangeState:(TGCTagcastManagerState)state;

/*!
 *  @method tagcastManager:didDiscoveredTagcast:
 *
 *  @param manager      TGCTagcastManager providing this information.
 *  @param tagcast      A dictionary containing received TAGCAST data.
 *
 *  @discussion         This method is invoked while scanning, upon the discovery of TAGCAST by manager.
 *
 *  @see                kTGCKeyIdentifier
 *  @see                kTGCKeyEntityNumber
 *  @see                kTGCKeyData
 *  @see                kTGCKeyDistanceLevel
 *
 */
- (void)tagcastManager:(TGCTagcastManager *)manager didDiscoveredTagcast:(NSDictionary *)tagcast;

/*!
 *  @method tagcastManager:didScannedTagcasts:
 *
 *  @param manager      TGCTagcastManager providing this information.
 *  @param tagcasts     A list of NSDictionary objects representing all received TAGCAST on scanInterval.
 *
 *  @discussion         This method is invoked when the scan is completed in scanInterval.
 *                      tagcasts array is sorted in descending order of TGCDistanceLevel(Average).
 *
 *  @see                kTGCKeyIdentifier
 *  @see                kTGCKeyEntityNumber
 *  @see                kTGCKeyData
 *  @see                kTGCKeyDistanceLevel
 *
 */
- (void)tagcastManager:(TGCTagcastManager *)manager didScannedTagcasts:(NSArray *)tagcasts;

/*!
 *  @method tagcastManager:didScannedStrengthOrderTagcasts:
 *
 *  @param manager      TGCTagcastManager providing this information.
 *  @param tagcasts     A list of NSDictionary objects representing all received TAGCAST on scanInterval.
 *
 *  @discussion         Available in SDK 1.1.9 and later.
 *                      This method is invoked when the scan is completed in scanInterval.
 *                      tagcasts array is sorted in descending order of TGCDistanceLevel(Maximum).
 *
 *  @see                kTGCKeyIdentifier
 *  @see                kTGCKeyEntityNumber
 *  @see                kTGCKeyData
 *  @see                kTGCKeyDistanceLevel
 *
 */
- (void)tagcastManager:(TGCTagcastManager *)manager didScannedStrengthOrderTagcasts:(NSArray *)tagcasts;

/*!
 *  @method tagcastManager:didFailWithError:
 *
 *  @param manager      TGCTagcastManager providing this information.
 *  @param error        The cause of the failure.
 *
 *  @discussion         This method is invoked when an error occurs.
 *
 *  @see                TGCErrorCode
 *
 */
- (void)tagcastManager:(TGCTagcastManager *)manager didFailWithError:(NSError *)error;

/*!
 *  @method tagcastManager:differenceDeviceTimeInterval:
 *
 *  @param manager      TGCTagcastManager providing this information.
 *  @param interval     Difference between server time and device time.
 *
 *  @discussion         Available in SDK 1.1.2 and later.
 *                      This method is invoked when difference between server time and device time exceeds specified value.
 *
 */
- (void)tagcastManager:(TGCTagcastManager *)manager differenceDeviceTimeInterval:(NSTimeInterval)interval;


@end

