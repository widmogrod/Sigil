@import <AppKit/CPView.j>
@import <AppKit/CPColor.j>
@import <AppKit/CPGraphicsContext.j>
@import <Foundation/CPSet.j>


@implementation SIElementsView : CPView
{
}

- (id)init
{
	self = [super init];
	
	if (self)
	{
		
	}
	
	return self;
}

/*
	Zestaw elementów wchodzących w skład SIDocument
*/
- (CPSet)elements
{
	var elements = [[[self window] windowController] elements];
	if (!elements)
	{
		elements = [CPSet set];
	}
	return elements;
}

- (void)drawRect:(CPRect)aRect
{

    var bounds = [self bounds],
    	context = [[CPGraphicsContext currentContext] graphicsPort];                           

	CGContextBeginPath(context);
	
	var rect = CGRectMake(CGRectGetMinX(bounds) + 1, CGRectGetMinY(bounds) + 5,
		CGRectGetWidth(bounds) - 14, CGRectGetHeight(bounds) - 10);

	CGContextAddEllipseInRect(context, rect);

	CGContextClosePath(context);

	//CGContextFillPath(context);	
	//CGContextRestoreGState(context);	
	//CGContextStrokePath(context);
}




- (void)mouseMoved:(CPEvent)anEvent	
{
	console.log("mouseMoved");
	console.log("Type: ",[anEvent type]);
	console.log("Event: ", [[[anEvent window] windowController] elements]);
}

- (void)mouseDown(CPEvent)anEvent
{
	var location = [self convertPoint:[anEvent locationInWindow] fromView:nil];
	
	console.log("mouseDown");
	console.log(location);
	console.log("Type: ",[anEvent type]);
	console.log("Event: ", [[[anEvent window] windowController] elements]);
}

@end
