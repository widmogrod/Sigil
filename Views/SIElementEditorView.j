@import <AppKit/CPView.j>
@import <AppKit/CALayer.j>

@import "../Sigil/SIElement.j"

SIElementEditorViewShared = nil;

/*
	Edytor woidoku elementu odpowiada za:
	- rysowanie uchwytów zmieniających rozmiar elementu
	- edycje wartości w danym polu
*/
@implementation SIElementEditorView : CPView
{
	SIElement 			_element;
	SIElementsView 		_elementsView;
	
	CPTextField 		_textField;
	CGRect				_textFrame;
	
	CALayer				_rootLayer;

	
	(unsigned int)		_handleSize;

	CGRect 				_handleTopLeft;
	CGRect 				_handleTopRight;
	CGRect 				_handleBottomLeft;
	CGRect 				_handleBottomRight;
}

/*
	Jednocześnie można edytować tylko jeden element stąd
	wprowadzenie "Singletone"
*/
+ (id)sharedElementEditorView
{
	if (!SIElementEditorViewShared)
		SIElementEditorViewShared = [[SIElementEditorView alloc] initWithFrame:CGRectMakeZero()];
		
	return SIElementEditorViewShared;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if (self)
    {
    	// ustaw domyślny rozmiar uchwytów
    	_handleSize = 8;
    	
    	_rootLayer = [CALayer layer];
        
        [self setWantsLayer:YES];
        [self setLayer:_rootLayer];
        
        [_rootLayer setDelegate:self];
        [_rootLayer setBackgroundColor:[CPColor blueColor]];

    	var bounds = [self bounds];

    	// domyślna wielkośc okna do edycji wartości
    	_textFrame = CGRectMake(CGRectGetMinX(bounds),
    							CGRectGetMinY(bounds),
    							250, 100);

    	_textField =  [[CPTextField alloc] initWithFrame:_textFrame]; 
		[_textField setEditable:YES];
		[_textField setBezeled:YES];
		[_textField setDelegate:self];
		
		[self setBackgroundColor:[CPColor whiteColor]];
    }
    
    return self;
}

- (void)mouseUp:(CPEvent)anEvent
{
}

- (void)mouseMoved:(CPEvent)anEvent
{
}

- (void)mouseExited:(CPEvent)anEvent
{
	console.log("ex2");
}

- (void)setElement:(SIElement)anElement
{
	if (_element == anElement)
		return;
	
	_element = anElement;
	
	/* @var elementsView SIElementsView */
	var elementsView = [_element elementsView];

	if (_elementsView != elementsView)
	{
		// usunięcie okna edycji elementu w poprzednim widoku
		[[_elementsView superview] willRemoveSubview:self];
		
		_elementsView = elementsView;
		
		// dodanie okna edycji w nowym widoku
		[[_elementsView superview] addSubview:self];
	}
}

/*
	Edycja wartości elementu
*/
- (void)displayEditable
{
	[self setLayer:nil];
	[self setWantsLayer:NO];
	
	var bounds = [_element bounds],
		value = [_element value];

	// oblicz punk zaczepienia okna do edycji
    [self setFrameOrigin: CGPointMake(CGRectGetMinX(bounds),
    								 CGRectGetMinY(bounds))];

	// oblicz wilkośc wymiaru okna w zależności
	// czy jest to edycja czy przesunięcie/"zmina rozmiru" elementu
	[self setFrameSize: CGSizeMake(CGRectGetWidth(_textFrame),
    								 CGRectGetHeight(_textFrame))];

	// ustaw wartość w polu do edycji
	[_textField setObjectValue:value];

	[self addSubview:_textField];

	//[self displayElementEditorInElementsView];
}

/*
	Edycja rozmiaru elementu
*/
- (void)displayResizable
{
	[self setLayer:_rootLayer];
	[self setWantsLayer:YES];

	// usuń edycję wartości
	[self willRemoveSubview:_textField];

	var bounds = [_element bounds];

	// oblicz punk zaczepienia okna do edycji
    [self setFrameOrigin: CGPointMake(CGRectGetMinX(bounds)-5,
    								 CGRectGetMinY(bounds)-5)];

	// oblicz wilkośc wymiaru okna w zależności
	// czy jest to edycja czy przesunięcie/"zmina rozmiru" elementu
	[self setFrameSize: CGSizeMake(CGRectGetWidth(bounds)+10,
    								 CGRectGetHeight(bounds)+10)];

	// Druga metoda pozycjonowania
	[_elementsView addSubview:self
				   positioned:CPWindowBelow
				   relativeTo:_elementsView];
	
	//[self displayElementEditorInElementsView];
	// [[_elementsView superview] addSubview:[_element elementsView]];
	[_element draw];
}

/*
	Wyświetlanie edytora elementu w widoku elementów
	
	Ważne jest by modyfikować widoku poprzez "superview":
		
		[_elementsView superview]

	w przeciwnym razie będzie okno edycji będzie pod elementem edytowanym 
	(okno edycji nie będzie na wierzchu)
	- zawsze można pozycjonować..
*/
- (void)displayElementEditorInElementsView
{
	/* @var elementsView SIElementsView */
	var elementsView = [_element elementsView];

	if (_elementsView != elementsView)
	{
		// usunięcie okna edycji elementu w poprzednim widoku
		[_elementsView willRemoveSubview:self];
		
		_elementsView = elementsView;
		
		// dodanie okna edycji w nowym widoku
		[_elementsView addSubview:self];
	}
}

/*
- (void)drawRect:(CGRect)aRect
{
	console.log("RYSOWANIE.2", aRect);

	var bounds = [self bounds],
    	context = [[CPGraphicsContext currentContext] graphicsPort];                           


	CGContextBeginPath(context);
	
	var rect = CGRectMake(155,155,180,180);

	CGContextAddEllipseInRect(context, rect);

	CGContextClosePath(context);

	CGContextFillPath(context);	
	//CGContextRestoreGState(context);	
	//CGContextStrokePath(context);
*/

/*	console.log("rysowanie");
//	var bounds = CGRectInset([_element bounds], 5.0, 5.0),
	var bounds = [_element bounds],
        context = [[CPGraphicsContext currentContext] graphicsPort],
        radius = CGRectGetWidth(bounds) / 2.0;
        
    console.log(_element);
    
    CGContextSetStrokeColor(context, [CPColor colorWithCalibratedRed:0.0 green:1.0 blue:0.0 alpha:1.0]);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeEllipseInRect(context, bounds);

    CGContextSetAlpha(context, 0.5);
    CGContextSetFillColor(context, [CPColor colorWithCalibratedRed:0.0 green:1.0 blue:0.0 alpha:1.0]);
    CGContextFillEllipseInRect(context, bounds);
        
    CGContextSetAlpha(context, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(CGRectGetMidX(bounds) + COS(rotationRadians) * radius - SharedEditorhandleadius, CGRectGetMidY(bounds) + SIN(rotationRadians) * radius - SharedEditorhandleadius, SharedEditorhandleadius * 2.0, SharedEditorhandleadius * 2.0));
   */
//}

- (void)controlTextDidBeginEditing:(CPNotification)aNotification
{
	//console.log([[aNotification object] objectValue], "-- controlTextDidBeginEditing");
}

- (void)controlTextDidChange:(CPNotification)aNotification
{
	//console.log([[aNotification object] objectValue], "-- controlTextDidBeginEditing");
}

- (void)controlTextDidEndEditing:(CPNotification)aNotification
{
	[_element setValue:[[aNotification object] objectValue]];
	[_elementsView setNeedsDisplay:YES];
}

/*
	Oblicza, klkuluje wymiary uchwytów względem wymiaru edytora
	(należy pamiętać że wymiar edytor jest ustalany względem
	 edytowanego elementu i w zalerzności czy editable|resizable)
*/
- (void)calculateHandlesRect
{
	var bounds = [self bounds];
	
	// uchwyty
	_handleTopLeft 		= CGRectMake(CGRectGetMinX(bounds), 
									 CGRectGetMinY(bounds),
									 _handleSize,
									 _handleSize);

	_handleTopRight		= CGRectMake(CGRectGetMaxX(bounds)-_handleSize,
									 CGRectGetMinY(bounds),
									 _handleSize,
									 _handleSize);

	_handleBottomLeft	= CGRectMake(CGRectGetMinX(bounds),
									 CGRectGetMaxY(bounds)-_handleSize,
									 _handleSize,
									 _handleSize);

	_handleBottomRight	= CGRectMake(CGRectGetMaxX(bounds)-_handleSize,
									 CGRectGetMaxY(bounds)-_handleSize,
									 _handleSize,
									 _handleSize);	
}

/*
	Inicjowane są wymiary uchwytów względem wymiaru edytora
	(a edytor jest względem edytowanego elementu)
*/
- (CPArray)handersRects
{	
	[self calculateHandlesRect];

	var rects = [_handleTopLeft,
				 _handleTopRight,
				 _handleBottomLeft, 
				 _handleBottomRight];

	return rects;
}

/*
	@delegate -(void)drawLayer:(CALayer)layer inContext:(CGContextRef)ctx;
    If the delegate implements this method, the CALayer will
    call this in place of its \c -drawInContext:.
    @param layer the layer to draw for
    @param ctx the context to draw on
*/
-(void)drawLayer:(CALayer)layer inContext:(CGContextRef)context
{

	var bounds = [self bounds];
	
	var radius = 5.0;
	
	var hasShadow = NO;
	
	var fillColor = [CPColor whiteColor];
	var borderColor = [CPColor yellowColor];
	var strokeColor = [CPColor redColor];
	
	
    CGContextSetLineWidth(context, 1.0);
	CGContextSetFillColor(context, fillColor);
	CGContextSetStrokeColor(context, strokeColor);
	
	// rysowanie uchwytów
	CGContextFillRects(context, [self handersRects]);

	var rect = CGRectMake(CGRectGetMinX(bounds)-5,
							CGRectGetMinY(bounds)-5,
							CGRectGetWidth(bounds)+10,
							CGRectGetHeight(bounds)+10);
	
	CGContextStrokeRect(context, bounds);

	/*				
	CGContextSaveGState(context);
	if (hasShadow === YES)
	{
		CGContextSetShadowWithColor(context, CGSizeMake(1,1), 2.0, strokeColor);
	}
	/*
	CGContextBeginPath(context);
	
    	var rect = CGRectMake(CGRectGetMinX(bounds) + 1, CGRectGetMinY(bounds) + 5,
			CGRectGetWidth(bounds) - 14, CGRectGetHeight(bounds) - 10);

		CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
		CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3.0 * Math.PI / 2.0, 0, 1);
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - (CGRectGetHeight(rect) / 2.0) - 5);				
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect) + 9, CGRectGetMaxY(rect) - (CGRectGetHeight(rect) / 2.0));
		CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - (CGRectGetHeight(rect) / 2.0) + 5);
		CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0.0, Math.PI / 2.0, 1);
		CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, Math.PI / 2.0, Math.PI, 1);					
		CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, Math.PI, 3.0 * Math.PI / 2.0, 1);				

	CGContextClosePath(context);
	CGContextSetAlpha(context, fillOpacity);
	CGContextFillPath(context);	
	CGContextRestoreGState(context);	
	CGContextStrokePath(context);
}

/*
	@delegate  -(void)displayLayer:(CALayer)layer;
    The delegate can override the layer's \c -display method
    by implementing this method.
*/
/*
-(void)displayLayer:(CALayer)layer
{
}
*/

@end