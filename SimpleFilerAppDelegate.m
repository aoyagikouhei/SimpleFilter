#import "SimpleFilerAppDelegate.h"
#import "FileNode.h"
#import "CustomCell.h"

@implementation SimpleFilerAppDelegate

@synthesize window;
@synthesize outlineColumn;
@synthesize tableColumn;
@synthesize root;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[outlineColumn setDataCell:[[[CustomCell alloc] init] autorelease]];
	[tableColumn setDataCell:[[[CustomCell alloc] init] autorelease]];
	
	self.root = [[[FileNode alloc] initWithPath:NSHomeDirectory()] autorelease];
}

@end
