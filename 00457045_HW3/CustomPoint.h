#import <Foundation/Foundation.h>

@interface CustomPoint : NSObject
@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) NSInteger y;


- (id)initWithX:(NSInteger)x y:(NSInteger)y;
- (BOOL)isEqual:(CustomPoint *)other;

@end
