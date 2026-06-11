extends TextureButton

var pos;
var possibleMoves = [];
var guardedMoves = [];
var white = false;
var b;
var selected = false;
var val = 3;
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
	
	if (pos[0]+1 < 8):
		if (pos[1]+2 < 8):
			if (!board[[pos[0]+1,pos[1]+2]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]+2]);
			elif (pieces[[pos[0]+1,pos[1]+2]].white):
				possibleMoves.append([pos[0]+1,pos[1]+2]);
			else:
				guardedMoves.append([pos[0]+1,pos[1]+2]);
		if (pos[1]-2 > -1):
			if (!board[[pos[0]+1,pos[1]-2]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]-2]);
			elif (pieces[[pos[0]+1,pos[1]-2]].white):
				possibleMoves.append([pos[0]+1,pos[1]-2]);
			else:
				guardedMoves.append([pos[0]+1,pos[1]-2]);
	if (pos[0]-1 > -1):
		if (pos[1]+2 < 8):
			if (!board[[pos[0]-1,pos[1]+2]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]+2]);
			elif (pieces[[pos[0]-1,pos[1]+2]].white):
				possibleMoves.append([pos[0]-1,pos[1]+2]);
			else:
				guardedMoves.append([pos[0]-1,pos[1]+2]);
		if (pos[1]-2 > -1):
			if (!board[[pos[0]-1,pos[1]-2]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]-2]);
			elif (pieces[[pos[0]-1,pos[1]-2]].white):
				possibleMoves.append([pos[0]-1,pos[1]-2]);
			else:
				guardedMoves.append([pos[0]-1,pos[1]-2]);
				
	if (pos[0]+2 < 8):
		if (pos[1]+1 < 8):
			if (!board[[pos[0]+2,pos[1]+1]].occupied):
				possibleMoves.append([pos[0]+2,pos[1]+1]);
			elif (pieces[[pos[0]+2,pos[1]+1]].white):
				possibleMoves.append([pos[0]+2,pos[1]+1]);
			else:
				guardedMoves.append([pos[0]+2,pos[1]+1]);
		if (pos[1]-1 > -1):
			if (!board[[pos[0]+2,pos[1]-1]].occupied):
				possibleMoves.append([pos[0]+2,pos[1]-1]);
			elif (pieces[[pos[0]+2,pos[1]-1]].white):
				possibleMoves.append([pos[0]+2,pos[1]-1]);
			else:
				guardedMoves.append([pos[0]+2,pos[1]-1]);
	if (pos[0]-2 > -1):
		if (pos[1]+1 < 8):
			if (!board[[pos[0]-2,pos[1]+1]].occupied):
				possibleMoves.append([pos[0]-2,pos[1]+1]);
			elif (pieces[[pos[0]-2,pos[1]+1]].white):
				possibleMoves.append([pos[0]-2,pos[1]+1]);
			else:
				guardedMoves.append([pos[0]-2,pos[1]+1]);
		if (pos[1]-1 > -1):
			if (!board[[pos[0]-2,pos[1]-1]].occupied):
				possibleMoves.append([pos[0]-2,pos[1]-1]);
			elif (pieces[[pos[0]-2,pos[1]-1]].white):
				possibleMoves.append([pos[0]-2,pos[1]-1]);
			else:
				guardedMoves.append([pos[0]-2,pos[1]-1]);
				
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
