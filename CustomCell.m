//
//  CustomCell.m
//  SimpleFiler
//
//  Created by 青柳 公右平 on 11/02/03.
//  Copyright 2011 myself. All rights reserved.
//

#import "CustomCell.h"
#import "FileNode.h"


@implementation CustomCell

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	FileNode* node = [self objectValue];
	
	[controlView lockFocus];
	NSPoint p1 = cellFrame.origin;
	p1.x += 0;
	p1.y += 0 + [node.icon size].height;
	[node.icon compositeToPoint:p1 operation:NSCompositeSourceOver];
	
	NSPoint p2 = cellFrame.origin;
	p2.x += 20;
	p2.y += 0;
	NSDictionary* attrs = [NSDictionary dictionary];
	[node.name drawAtPoint:p2 withAttributes:attrs];
	[controlView unlockFocus];
}

- (id)copyWithZone:(NSZone *)zone
{
	CustomCell* cell = (CustomCell*)[super copyWithZone:zone];
	return cell;
}

@end
