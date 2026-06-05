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
	findPossibleMoves();
	print("white rook");
	print(pos);
	print(possibleMoves);
	
func findPossibleMoves():
	possibleMoves.clear();
	
	#horizontal checks
	for i in range(8):
		if (pos[0] + (i+1) < 8):
			if (!b.board[[pos[0]+(i+1),pos[1]]].occupied):
				possibleMoves.append([pos[0]+(i+1),pos[1]]);
			elif (!b.pieces[[pos[0]+(i+1),pos[1]]].white):
				possibleMoves.append([pos[0]+(i+1),pos[1]]);
				break;
			else:
				break;
		else:
			break;
			
	for i in range(8):
		if (pos[0] - (i+1) > -1):
			if (!b.board[[pos[0]-(i+1),pos[1]]].occupied):
				possibleMoves.append([pos[0]-(i+1),pos[1]]);
			elif (!b.pieces[[pos[0]-(i+1),pos[1]]].white):
				possibleMoves.append([pos[0]-(i+1),pos[1]]);
				break;
			else:
				break;
		else:
			break;
			
	#vertical checks
	for i in range(8):
		if (pos[1] + (i+1) < 8):
			if (!b.board[[pos[0],pos[1]+(i+1)]].occupied):
				possibleMoves.append([pos[0],pos[1]+(i+1)]);
			elif (!b.pieces[[pos[0],pos[1]+(i+1)]].white):
				possibleMoves.append([pos[0],pos[1]+(i+1)]);
				break;
			else:
				break;
		else:
			break;
		
	for i in range(8):
		if (pos[1]-(i+1) > 0):
			if (!b.board[[pos[0],pos[1]-(i+1)]].occupied):
				possibleMoves.append([pos[0],pos[1]-(i+1)]);
			elif (!b.pieces[[pos[0],pos[1]-(i+1)]].white):
				possibleMoves.append([pos[0],pos[1]-(i+1)]);
				break;
			else:
				break;
		else:
			break;
	
	#clear dupes
	var temp = {};
	for move in possibleMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	possibleMoves = temp.keys();
	
	b.showPossible(possibleMoves);
