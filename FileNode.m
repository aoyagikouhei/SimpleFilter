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
	[m_children release];
	[m_files release];
	[super dealloc];
}

- (NSMutableArray*) children
{
	if (!m_children) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		BOOL isDir, valid = [fileManager fileExistsAtPath:path isDirectory:&isDir];
		if (valid & isDir) {
			NSError* error;
			NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:&error];
			NSInteger cnt, numChildren = [array count];
			m_children = [[NSMutableArray alloc] initWithCapacity:numChildren];
			m_files = [[NSMutableArray alloc] initWithCapacity:numChildren];
			for (cnt = 0; cnt < numChildren; cnt++) {
				NSString *filePath = [path stringByAppendingPathComponent:[array objectAtIndex:cnt]];
				valid = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
				if (valid && isDir) {
					FileNode *item = [[[FileNode alloc] initWithPath:filePath] autorelease];
					[m_children addObject:item];
				}
				if (valid && !isDir) {
					FileNode *item = [[[FileNode alloc] initWithPath:filePath] autorelease];
					[m_files addObject:item];
				}
			}
			if (0 == [m_children count]) {
				[m_children release];
				m_children = nil;
				m_isLeaf = YES;
			} else {
				m_isLeaf = NO;
			}
		} else {
			m_isLeaf = YES;
			m_children = nil;
		}
	}
	return m_children;
}

- (BOOL) isLeaf
{
	if (!m_children) {
		[self children];
	}
	return m_isLeaf;
}

- (NSMutableArray*) files
{
	if (!m_children) {
		[self children];
	}
	return m_files;
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
