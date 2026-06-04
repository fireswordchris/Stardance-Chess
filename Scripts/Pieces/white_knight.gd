extends TextureButton

var pos;
var possibleMoves = [];
var white = true;
var b;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	print("white knight");
	print(pos);
	print(possibleMoves);


func findPossibleMoves():
	pass
