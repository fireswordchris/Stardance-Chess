extends Button

var x;
var y;

var white;

var occupied = false;
var b;

var tintAmount = .1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tint():
	if (white):
		$ColorRect.color = b.white;
		$ColorRect.color = Color($ColorRect.color.r-tintAmount,$ColorRect.color.g,$ColorRect.color.b-tintAmount);
	else:
		$ColorRect.color = b.black;
		$ColorRect.color = Color($ColorRect.color.r-tintAmount,$ColorRect.color.g,$ColorRect.color.b-tintAmount);

func unTint():
	if (white):
		$ColorRect.color = b.white;
	else:
		$ColorRect.color = b.black;

func _on_pressed():
	b.unShowPossible();
	print(x);
	print(y);
	print(white);
	print(occupied);
	
