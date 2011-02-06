#import "FileNode.h"


@implementation FileNode

@synthesize name;
@synthesize path;
@synthesize icon;

- (id)initWithPath:(NSString*)filePath
{
	self = [super init];
	if (!self) {
		return nil;
	}
	path = filePath;
	[path retain];
	name = [[NSFileManager defaultManager] displayNameAtPath:path];
	[name retain];
	icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
	[icon retain];
	[icon setSize:NSMakeSize(16, 16)];
	return self;
}

- (void) dealloc
{
	[path release];
	[name release];
	[icon release];
	[children release];
	[files release];
	[super dealloc];
}

- (NSMutableArray*) children
{
	if (!children) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		BOOL isDir, valid = [fileManager fileExistsAtPath:path isDirectory:&isDir];
		if (valid & isDir) {
			NSError* error;
			NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:&error];
			NSInteger cnt, numChildren = [array count];
			children = [[NSMutableArray alloc] initWithCapacity:numChildren];
			files = [[NSMutableArray alloc] initWithCapacity:numChildren];
			for (cnt = 0; cnt < numChildren; cnt++) {
				NSString *filePath = [path stringByAppendingPathComponent:[array objectAtIndex:cnt]];
				valid = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
				if (valid && isDir) {
					FileNode *item = [[[FileNode alloc] initWithPath:filePath] autorelease];
					[children addObject:item];
				}
				if (valid && !isDir) {
					FileNode *item = [[[FileNode alloc] initWithPath:filePath] autorelease];
					[files addObject:item];
				}
			}
			if (0 == [children count]) {
				[children release];
				children = nil;
				isLeaf = YES;
			} else {
				isLeaf = NO;
			}
		} else {
			isLeaf = YES;
			children = nil;
		}
	}
	return children;
}

- (BOOL) isLeaf
{
	if (!children) {
		[self children];
	}
	return isLeaf;
}

- (NSMutableArray*) files
{
	if (!children) {
		[self children];
	}
	return files;
}

- (FileNode*) me
{
	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	FileNode *copy = [[FileNode allocWithZone:zone] initWithPath:path];
	return copy;
}

@end
