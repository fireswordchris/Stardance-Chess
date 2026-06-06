extends TextureButton

var pos;
var possibleMoves = [];
var white = true;
var pieces;
var b;
var selected = false;
var type = "king";
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
	
	findPossibleMoves();
	print("white king");
	print(pos);
	
	
func findPossibleMoves():
	possibleMoves.clear();
	
	if (pos[0]+1 < 8):
		if (pos[1]+1 < 8):
			if (!b.board[[pos[0]+1,pos[1]+1]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]+1]);
			elif (!b.pieces[[pos[0]+1,pos[1]+1]].white):
				possibleMoves.append([pos[0]+1,pos[1]+1]);
		if (pos[1]-1 > -1):
			if (!b.board[[pos[0]+1,pos[1]-1]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]-1]);
			elif (!b.pieces[[pos[0]+1,pos[1]-1]].white):
				possibleMoves.append([pos[0]+1,pos[1]-1]);
		if (!b.board[[pos[0]+1,pos[1]]].occupied):
			possibleMoves.append([pos[0]+1,pos[1]]);
		elif (!b.pieces[[pos[0]+1,pos[1]]].white):
			possibleMoves.append([pos[0]+1,pos[1]]);
	if (pos[0]-1 > -1):
		if (pos[1]+1 < 8):
			if (!b.board[[pos[0]-1,pos[1]+1]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]+1]);
			elif (!b.pieces[[pos[0]-1,pos[1]+1]].white):
				possibleMoves.append([pos[0]-1,pos[1]+1]);
		if (pos[1]-1 > -1):
			if (!b.board[[pos[0]-1,pos[1]-1]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]-1]);
			elif (!b.pieces[[pos[0]-1,pos[1]-1]].white):
				possibleMoves.append([pos[0]-1,pos[1]-1]);
		if (!b.board[[pos[0]-1,pos[1]]].occupied):
			possibleMoves.append([pos[0]-1,pos[1]]);
		elif (!b.pieces[[pos[0]-1,pos[1]]].white):
			possibleMoves.append([pos[0]-1,pos[1]]);
	if (pos[1]+1 < 8):
		if (!b.board[[pos[0],pos[1]+1]].occupied):
			possibleMoves.append([pos[0],pos[1]+1]);
		elif (!b.pieces[[pos[0],pos[1]+1]].white):
			possibleMoves.append([pos[0],pos[1]+1]);
	if (pos[1]-1 > -1):
		if (!b.board[[pos[0],pos[1]-1]].occupied):
			possibleMoves.append([pos[0],pos[1]-1]);
		elif (!b.pieces[[pos[0],pos[1]-1]].white):
			possibleMoves.append([pos[0],pos[1]-1]);
	
	#clear dupes
	var temp = {};
	for move in possibleMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	possibleMoves = temp.keys();
	
	b.showPossible(possibleMoves);
