@import <Foundation/CPObject.j>

/*
	Powiadomienie wysyłane gdy zmienia się stan zaznaczenia elementu
*/
SIElementDidChangeSelectionNotification = @"SIElementDidChangeSelectionNotification",
SIElementDidChangeValueNotification = @"SIElementDidChangeValueNotification";

/*
	Abstrakcyjna klasa elementu dokumentu,
	ma zaimplementowane wszystkie podstawowe metody
	
	TODO: zmienne klasowe są accessorami, czy settery
		  nie powinny zostać zaimplementowane?
		  - Zysk z takiego działania była by możliwośc 
		    wysłania wiadomość do metody o ponownym narysowaniy

	TODO: Czy dodać może delegacje zamiast notification center?
		  - dodałem setElementsView
		    
*/
@implementation SIElement : CPObject
{
	// wartość elementu
	CPString 			_value;
	
	// wysokość i szerokość
	(unsigned int) 		_width @accessors(property=width);
	(unsigned int) 		_height @accessors(property=height);

	// położenie (x,y)
	(unsigned int) 		_positionX @accessors(property=positionX);
	(unsigned int) 		_positionY @accessors(property=positionY);
	
	(BOOL) 				_selected;
	
	// widok w którym element jest wyświetlany
	SIElementsView 		_elementsView @accessors(property=elementsView);
}

- (id)init
{
	self = [super init];
	if (self)
	{
		_selected = NO;
	}

	return self;
}

/*
	Oznacz element jako zaznaczony
*/
- (void)setSelected:(BOOL)flag
{
	_selected = !!flag;

	// wyslij powiadomienie że zostało zmienione zaznaczenie elementu
	[[CPNotificationCenter defaultCenter] 
			postNotificationName:SIElementDidChangeSelectionNotification
						  object:self
						userInfo:_selected];

	//[SIElementEditorView];
}

- (BOOL)selected
{
	return _selected;
}

- (void)setValue:(CPString)aValue
{
	// tworzenie słownika z parą vartość klucz
	var dict = [CPDictionary dictionaryWithObjectsAndKeys:aValue, @"newValue", _value, @"oldValue"];

	// ustaw nową wartość
	_value = aValue;

	// wyslij powiadomienie że zostało zmieniona wartość elementu
	// FIXME: chwilowo wyłączone, testowanie SIElementEditorView
/*
	[[CPNotificationCenter defaultCenter] 
			postNotificationName:SIElementDidChangeValueNotification
						  object:self
					userInfo: dict];
*/
}

- (void)value
{
	return _value;
}

/*
	Tworzenie wymiaru elementu (CGRect) zrozumiałego dla CP
*/
- (CGRect)rect
{
	return CGRectMake(_positionX, _positionY, _width, _height);
}

/*
	Powtórzenie metody w ramch kompatybilnosci (którą wprowdzę)
*/
- (CGRect)bounds
{
	return [self rect];
}

- (void)draw
{
	if (_elementsView)
		[self willDrawInView:_elementsView];
}

-(void)setScaleProportions:(CGSize)aSize
{}

/*
	Metoda odpowiada za rysowanie elementu 
	w widoku dokumentu {@see SIElementsView}
*/
- (void)willDrawInView:(SIElementsView)anView
{
	//[self setElementsView:anView];
	alert("[SIElement willDrawInView:] musi zostać zaimplementowana");
}

/*
	Metoda jest specjalizowana w nad klasie (czy nad klasa - czy pod klasa :/ ),
	Zwraca tablicę zawierającą nazwy opcji elementów
*/
- (CPArray)elementOptions
{
	alert("[SIElement elementOptions:] musi zostać zaimplementowana");
	
}
@end
