@import <AppKit/CPView.j>
@import <AppKit/CPColor.j>
@import <AppKit/CPGraphicsContext.j>
@import <Foundation/CPSet.j>

@import "../Sigil/SIElementManager.j";
@import "SIElementEditorView.j";


@implementation SIElementsView : CPView
{
}

- (id)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
	if (self)
	{
		/*
			Ustaw widok jako obserwator zmiany wartości elementu
			TODO: Zastanowic się cz nie zrobić pętli dla każdego elemtnu
				  i nie dodać [element setDelegate:self]
				  - teraz jest troszeczkę jak jazda bez trzymanki,
				  - co będzie jeżeli powstanie dużo nowych dokumentów?
				  - czy utworzenie nowego dokumentu powoduje że stary znika
				    * nie, nowy dokument to nowy obiekt
		*/
		[[CPNotificationCenter defaultCenter]
				addObserver:self
				   selector:@selector(elementDidChangeValue:)
					   name:SIElementDidChangeValueNotification
	 			     object:nil];
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

/*
	Zwracanie zestawu elementów, które są zaznaczone
*/
- (CPSet)selectedElements
{
	var selectedElements = [[[self window] windowController] selectedElements];
	if (!selectedElements)
	{
		selectedElements = [CPSet set];
	}

	return selectedElements;
}

/*
	Metoda wywoływany gdy wartość elementu zostanie zmodyfikowana
	Zmiana wartości elemtnu powoduje że nalerzy go jeszcze raz wyrenderować.
*/
- (void)elementDidChangeValue:(CPNotification)aNotification
{
	var element = [aNotification object];

	[element willDrawInView:self];
}

/*
	Rysowanie elementów w tym widoku
*/
- (void)viewWillDraw
{
	console.log("RYSOWANIE:!");
	/*
		TODO: Czy każdy z elementów będzie (powinien być)
			  rysowany ponownie podczas zmieniania rozmiaru okna?
			  - bo między innymi wtedy ta metoda jest wywoływana - ponownie
	*/
	var elements = [[self elements] allObjects];
	for (var i = 0; i < [elements count]; i++)
	{
		var element = [elements objectAtIndex:i];
		

		// TODO: czy nie lepiej tak?		
		[element setElementsView:self];
		//[element setNeedsDisplay:YES];

		/*
			Rysujemy elementy .. magic ;]
		*/
		[element willDrawInView:self];
	}
}


- (void)drawRect:(CPRect)aRect
{
/*
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
*/
}


/*!
    Notifies the receiver that the user has clicked the mouse down in its area.
    @param anEvent contains information about the click
*/
- (void)mouseDown:(CPEvent)anEvent
{
	[super mouseDown:anEvent];

	// Relatywne współrzędne kliknięcia (dotyczą tylko tego okna)
	var location = [anEvent locationInWindow];

	var sharedElementEditorView = [SIElementEditorView sharedElementEditorView];

	console.log([anEvent clickCount]);

	var elements = [[self elements] allObjects];
	for (var i = 0; i < [elements count]; i++)
	{
		var element = [elements objectAtIndex:i];
		
		if ([SIElementManager element:element
						containsPoint:location])
		{
			[element setSelected:YES];

			[sharedElementEditorView setElement:element];

			if ([anEvent clickCount] > 1)
			{
				//[sharedElementEditorView displayEditable];
			} else
			if ([anEvent clickCount] == 1)
			{
				//[sharedElementEditorView displayEditable];
				[sharedElementEditorView displayResizable];
			}

		} else {
			[element setSelected:NO];

			//[sharedElementEditorView setElement:nil view:nil];
		}
	}
}

/*!
    Notifies the receiver that the user has initiated a drag
    over it. A drag is a mouse movement while the left button is down.
    @param anEvent contains information about the drag
*/
/*
- (void)mouseDragged:(CPEvent)anEvent
{
	//console.log([anEvent locationInWindow].x, [anEvent locationInWindow].y);
    //console.log("mouseDragged");
    [super mouseDragged:anEvent];
}
*/

/*!
    Notifies the receiver that the user has released the left mouse button.
    @param anEvent contains information about the release
*/
/*
- (void)mouseUp:(CPEvent)anEvent
{
	[super mouseUp:anEvent];
}
*/

/*!
    Notifies the receiver that the user has moved the mouse (with no buttons down).
    @param anEvent contains information about the movement
*/
- (void)mouseMoved:(CPEvent)anEvent
{
	[super mouseMoved:anEvent];
}

- (void)mouseEntered:(CPEvent)anEvent
{
	[super mouseEntered:anEvent];
}

/*!
    Notifies the receiver that the mouse exited the receiver's area.
    @param anEvent contains information about the exit
*/

/*
- (void)mouseExited:(CPEvent)anEvent
{
	[super mouseExited:anEvent];
}
*/

/*!
    Notifies the receiver that the mouse scroll wheel has moved.
    @param anEvent information about the scroll
*/
- (void)scrollWheel:(CPEvent)anEvent
{
    [super scrollWheel:anEvent];
}

/*!
    Notifies the receiver that the user has pressed a key.
    @param anEvent information about the key press
*/
- (void)keyDown:(CPEvent)anEvent
{
    [super keyDown:anEvent];
}

/*!
    Notifies the receiver that the user has released a key.
    @param anEvent information about the key press
*/
- (void)keyUp:(CPEvent)anEvent
{
    [super keyUp:anEvent];
}

@end
