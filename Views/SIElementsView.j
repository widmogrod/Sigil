@import <AppKit/CPView.j>
@import <AppKit/CPColor.j>
@import <AppKit/CPGraphicsContext.j>
@import <Foundation/CPSet.j>

@import "../Sigil/SIElementManager.j";


@implementation SIElementsView : CPView
{
}

- (id)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
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

- (void)viewWillDraw
{
	/*
		TODO: Czy każdy z elementów będzie (powinien być)
			  rysowany ponownie podczas zmieniania rozmiaru okna?
			  - bo między innymi wtedy ta metoda jest wywoływana - ponownie
	*/
	var elements = [[self elements] allObjects];
	for (var i = 0; i < [elements count]; i++)
	{
		var element = [elements objectAtIndex:i];
		
		console.log([element value]);
		
		[element viewWillDrawInView:self];
	}
}

- (void)drawRect:(CPRect)aRect
{
    var bounds = [self bounds],
    	context = [[CPGraphicsContext currentContext] graphicsPort];                           

	CGContextBeginPath(context);
	
	var rect = CGRectMake(CGRectGetMinX(bounds) + 10, CGRectGetMinY(bounds) + 10,
		CGRectGetWidth(bounds) - 200, CGRectGetHeight(bounds) - 200);

	CGContextAddEllipseInRect(context, rect);

	CGContextClosePath(context);

	CGContextFillPath(context);	
	//CGContextRestoreGState(context);	
	//CGContextStrokePath(context);
	
}


/*!
    Notifies the receiver that the user has clicked the mouse down in its area.
    @param anEvent contains information about the click
*/
- (void)mouseDown:(CPEvent)anEvent
{
	// Relatywne współrzędne kliknięcia (dotyczą tylko tego okna)
	var location = [anEvent locationInWindow];

	var elements = [[self elements] allObjects];
	for (var i = 0; i < [elements count]; i++)
	{
		var element = [elements objectAtIndex:i];
		
		if ([SIElementManager element:element
						containsPoint:location])
		{
			[element setSelected:YES];
		} else {
			[element setSelected:NO];
		}
	}

	[super mouseDown:anEvent];
}

/*!
    Notifies the receiver that the user has initiated a drag
    over it. A drag is a mouse movement while the left button is down.
    @param anEvent contains information about the drag
*/
- (void)mouseDragged:(CPEvent)anEvent
{
	console.log([anEvent locationInWindow].x, [anEvent locationInWindow].y);
    console.log("mouseDragged");
}

/*!
    Notifies the receiver that the user has released the left mouse button.
    @param anEvent contains information about the release
*/
- (void)mouseUp:(CPEvent)anEvent
{
	[super mouseUp:anEvent];
    console.log("mouseUp");
}

/*!
    Notifies the receiver that the user has moved the mouse (with no buttons down).
    @param anEvent contains information about the movement
*/
- (void)mouseMoved:(CPEvent)anEvent
{
    console.log("mouseMoved");
}

- (void)mouseEntered:(CPEvent)anEvent
{
    console.log("mouseEntered");
}

/*!
    Notifies the receiver that the mouse exited the receiver's area.
    @param anEvent contains information about the exit
*/
- (void)mouseExited:(CPEvent)anEvent
{
    console.log("mouseExited");
}

/*!
    Notifies the receiver that the mouse scroll wheel has moved.
    @param anEvent information about the scroll
*/
- (void)scrollWheel:(CPEvent)anEvent
{
    console.log("scrollWheel");
}

/*!
    Notifies the receiver that the user has pressed a key.
    @param anEvent information about the key press
*/
- (void)keyDown:(CPEvent)anEvent
{
    console.log("keyDown");
}

/*!
    Notifies the receiver that the user has released a key.
    @param anEvent information about the key press
*/
- (void)keyUp:(CPEvent)anEvent
{
    console.log("keyUp");
}

@end
