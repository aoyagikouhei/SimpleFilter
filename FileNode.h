#import <Cocoa/Cocoa.h>


@interface FileNode : NSObject {
	NSMutableArray* children;
	NSMutableArray* files;
	BOOL isLeaf;
	NSString* name;
	NSString* path;
	NSImage* icon;
}
- (id)initWithPath:(NSString*)filePath;
- (NSMutableArray*) children;
- (BOOL) isLeaf;
- (NSMutableArray*) files;
- (FileNode*) me;

@property (assign,readonly) NSString* name;
@property (assign,readonly) NSString* path;
@property (assign,readonly) NSImage* icon;


@end
