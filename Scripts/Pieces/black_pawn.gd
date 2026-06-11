extends TextureButton

var pos;
var possibleMoves = [];
var guardedMoves = [];
var white = false;
var b;
var selected = false;
var val = 1;
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
	
	
func findPossibleMoves(pieces, board, checkOthers):
	guardedMoves.clear();
	possibleMoves.clear();
	
	if (pos[1] == 1 and !board[[pos[0],3]].occupied and !board[[pos[0],pos[1]+1]].occupied):
		possibleMoves.append([pos[0],3]);
	
	if (pos[1]+1 < 8):
		if (!board[[pos[0],pos[1]+1]].occupied):
			possibleMoves.append([pos[0],pos[1]+1]);
		
		if (pos[0] > 0):
			if (board[[pos[0]-1,pos[1]+1]].occupied and pieces[[pos[0]-1,pos[1]+1]].white):
				possibleMoves.append([pos[0]-1,pos[1]+1]);
			else:
				guardedMoves.append([pos[0]-1,pos[1]+1]);
		if (pos[0] < 7):
			if (board[[pos[0]+1,pos[1]+1]].occupied and pieces[[pos[0]+1,pos[1]+1]].white):
				possibleMoves.append([pos[0]+1,pos[1]+1]);
			else:
				guardedMoves.append([pos[0]+1,pos[1]+1]);
			
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
	#b.showPossible(possibleMoves);
