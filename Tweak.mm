#import <Foundation/Foundation.h>
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBAwayController.h>
#import <UIKit/UIKit.h>
#include <substrate.h>

MSHook(BOOL, SBAwayController$isPasswordProtected, SpringBoard *self, SEL sel) {
	BOOL enabled = [[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/passunlockenabled"];
	return enabled ? NO : _SBAwayController$isPasswordProtected(self, sel);
}

extern "C" void TweakInitialize() {
	_SBAwayController$isPasswordProtected = MSHookMessage(objc_getClass("SBAwayController"), @selector(isPasswordProtected), &$SBAwayController$isPasswordProtected);
}
