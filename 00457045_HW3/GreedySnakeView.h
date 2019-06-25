#import <UIKit/UIKit.h>
#define POINT_SIZE 25
#define WIDTH (int)([UIScreen mainScreen].bounds.size.width / POINT_SIZE - 1)
#define HEIGHT (int)(([UIScreen mainScreen].bounds.size.height - 50) / POINT_SIZE - 1)
typedef enum {
    kDown = 0,
    kLeft,
    kRight,
    kUp
}Orient;
@interface GreedySnakeView : UIView<UIAlertViewDelegate>
@property (nonatomic, assign) Orient orient;
@property (nonatomic,retain) NSTimer *timer;
@end
