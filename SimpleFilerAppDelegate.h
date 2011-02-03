#import <Cocoa/Cocoa.h>

@class FileNode;

@interface SimpleFilerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSTableColumn *outlineColumn;
	NSTableColumn *tableColumn;
	FileNode *root;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableColumn *outlineColumn;
@property (assign) IBOutlet NSTableColumn *tableColumn;

@property (assign) FileNode *root;

@end
