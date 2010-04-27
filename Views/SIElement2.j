@import <AppKit/CPImageView.j>

@implementation SIElement2 : CPImageView
{
	CPEvent _mouseDownEvent;
}

-(void)initWithFrame:(CGRect)aRect
{
	self = [super initWithFrame:aRect];
	if (self)
	{
        [self setImageScaling:CPScaleProportionally];
        
		//var bundle = [CPBundle mainBundle];
		//var iconPath = [bundle resourcePath:"SigilIcon_256x256.png"];
		//console.log(iconPath);
	
		var image = [[CPImage alloc] initWithContentsOfFile:"Resources/SigilIcon_256x256.png"];
	
		[self setImage:image];
	}
	return self;
}

- (void)mouseDown:(CPEvent)anEvent
{
    _mouseDownEvent = anEvent;
    
    /* location CGPoint */
	var location = [anEvent locationInWindow];
	console.log(location);

	// konwertuje położenie myszki dla tego widoku względem głównego okna
	var point = [self convertPoint:location 
						  fromView:nil];
	console.log(point);
}

- (void)mouseDragged:(CPEvent)anEvent
{
    var locationInWindow = [anEvent locationInWindow],
        mouseDownLocationInWindow = [_mouseDownEvent locationInWindow];

/*
    // FIXME: This is because Safari's drag hysteresis is 3px x 3px
    if ((ABS(locationInWindow.x - mouseDownLocationInWindow.x) < 3) &&
        (ABS(locationInWindow.y - mouseDownLocationInWindow.y) < 3))
        return;

    if (![_delegate respondsToSelector:@selector(collectionView:dragTypesForItemsAtIndexes:)])
        return;

    // If we don't have any selected items, we've clicked away, and thus the drag is meaningless.
    if (![_selectionIndexes count])
        return;

    if ([_delegate respondsToSelector:@selector(collectionView:canDragItemsAtIndexes:withEvent:)] &&
        ![_delegate collectionView:self canDragItemsAtIndexes:_selectionIndexes withEvent:_mouseDownEvent])
        return;

    // Set up the pasteboard
    var dragTypes = [_delegate collectionView:self dragTypesForItemsAtIndexes:_selectionIndexes];
*/

	var dragTypes = ["SIElement2"];

	var pasteboard = [CPPasteboard pasteboardWithName:CPDragPboard];
    [pasteboard declareTypes:dragTypes owner:self];

    var point = [self convertPoint:[anEvent locationInWindow] fromView:nil];

/*
    if (!_itemForDragging)
        _itemForDragging = [self newItemForRepresentedObject:_content[[_selectionIndexes firstIndex]]];
    else
        [_itemForDragging setRepresentedObject:_content[[_selectionIndexes firstIndex]]];
*/

    var view = self;

    /*[view setFrameSize:_itemSize];*/
    [view setAlphaValue:0.7];

/*
Inicjuje operację przeciągania od adresata do innego widoku który akceptuje przeciągane dane

Initiates a drag operation from the receiver to another view that accepts dragged data.

Parameters:
    	anImage 	the image to be dragged
    	aLocation 	the lower-left corner coordinate of anImage
    	mouseOffset 	the distance from the -mouseDown: location and the current location
    	anEvent 	the -mouseDown: that triggered the drag
    	aPastebaord 	the pasteboard that holds the drag data
    	aSourceObject 	the drag operation controller
    	slideBack 	Whether the image should 'slide back' if the drag is rejected 
*/

	console.log([view frame]);
	console.log(CGPointMake(CGRectGetMinX([view frame]), CGRectGetMaxY([view frame])));

    [self dragImage:[self image]
    	// prawy górny róg obbiektu który przesuwamy
        at:CGPointMake(CGRectGetMinX([view frame]), CGRectGetMinY([view frame]))
        
        // offset jest nieistotny (w wertsji 0.8)
        // jest liczony w @see CPDragServer dragView:fromWindow:at:offset:event:pasteboard:source:slideBack:
        offset:CGSizeMakeZero()
        event:_mouseDownEvent
        
        // możemy przekazać do pasteboard "nil" 
        // wtedy implicite będzie pobrany pasteboard "CPDragPboard"
        pasteboard:pasteboard
        source:self
        slideBack:YES];
}

/*
	method provided for integration with native pasteboard 

	- jeżeli nie przekaże danych w -mouseDragged: to dopiero tutaj
	  sa pobierane dane
	  Może i raczej ma to duże znaczenie wydajnościowe.. gdy trzeba by było
	  serializować duże ilosci dancyh
*/
- (CPData)pasteboard:(CPPasteboard)aPasteboard provideDataForType:(CPString)aType
{
	[aPasteboard setData:[CPKeyedArchiver archivedDataWithRootObject:[self image]] forType:aType];
	
	console.log("dostarczam dane dla typu", aType)
}

@end
