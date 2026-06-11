extends TextureButton

var pos;
var possibleMoves = [];
var guardedMoves = [];
var white = true;
var b;
var selected = false;
var val = 5;

var notMoved = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if (b.selectedPiece != null):
		b.selectedPiece.selected = false;
	b.selectedPiece = self;
	selected = true;
	
	findPossibleMoves(b.pieces, b.board, true);
	b.showPossible(possibleMoves);
	
func findPossibleMoves(pieces, board, checkOthers):
	guardedMoves.clear();
	possibleMoves.clear();
	
	#horizontal checks
	for i in range(8):
		if (pos[0] + (i+1) < 8):
			if (!board[[pos[0]+(i+1),pos[1]]].occupied):
				possibleMoves.append([pos[0]+(i+1),pos[1]]);
			elif (!pieces[[pos[0]+(i+1),pos[1]]].white):
				possibleMoves.append([pos[0]+(i+1),pos[1]]);
				break;
			else:
				guardedMoves.append([pos[0]+(i+1),pos[1]]);
				break;
		else:
			break;
			
	for i in range(8):
		if (pos[0] - (i+1) > -1):
			if (!board[[pos[0]-(i+1),pos[1]]].occupied):
				possibleMoves.append([pos[0]-(i+1),pos[1]]);
			elif (!pieces[[pos[0]-(i+1),pos[1]]].white):
				possibleMoves.append([pos[0]-(i+1),pos[1]]);
				break;
			else:
				guardedMoves.append([pos[0]-(i+1),pos[1]]);
				break;
		else:
			break;
			
	#vertical checks
	for i in range(8):
		if (pos[1] + (i+1) < 8):
			if (!board[[pos[0],pos[1]+(i+1)]].occupied):
				possibleMoves.append([pos[0],pos[1]+(i+1)]);
			elif (!pieces[[pos[0],pos[1]+(i+1)]].white):
				possibleMoves.append([pos[0],pos[1]+(i+1)]);
				break;
			else:
				guardedMoves.append([pos[0],pos[1]+(i+1)]);
				break;
		else:
			break;
		
	for i in range(8):
		if (pos[1]-(i+1) > -1):
			if (!board[[pos[0],pos[1]-(i+1)]].occupied):
				possibleMoves.append([pos[0],pos[1]-(i+1)]);
			elif (!pieces[[pos[0],pos[1]-(i+1)]].white):
				possibleMoves.append([pos[0],pos[1]-(i+1)]);
				break;
			else:
				guardedMoves.append([pos[0],pos[1]-(i+1)]);
				break;
		else:
			break;
	
	#clear dupes
	var temp = {};
	for move in possibleMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	possibleMoves = temp.keys();
	temp = {};
	for move in guardedMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	guardedMoves = temp.keys();
