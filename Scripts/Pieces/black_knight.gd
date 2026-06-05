extends TextureButton

var pos;
var possibleMoves = [];
var white = false;
var b;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	findPossibleMoves();
	print("black knight");
	print(pos);
	print(possibleMoves);


func findPossibleMoves():
	possibleMoves.clear();
	
	if (pos[0]+1 < 8):
		if (pos[1]+2 < 8):
			if (!b.board[[pos[0]+1,pos[1]+2]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]+2]);
			elif (b.pieces[[pos[0]+1,pos[1]+2]].white):
				possibleMoves.append([pos[0]+1,pos[1]+2]);
		if (pos[1]-2 > -1):
			if (!b.board[[pos[0]+1,pos[1]-2]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]-2]);
			elif (b.pieces[[pos[0]+1,pos[1]-2]].white):
				possibleMoves.append([pos[0]+1,pos[1]-2]);
	if (pos[0]-1 > -1):
		if (pos[1]+2 < 8):
			if (!b.board[[pos[0]-1,pos[1]+2]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]+2]);
			elif (b.pieces[[pos[0]-1,pos[1]+2]].white):
				possibleMoves.append([pos[0]-1,pos[1]+2]);
		if (pos[1]-2 > -1):
			if (!b.board[[pos[0]-1,pos[1]-2]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]-2]);
			elif (b.pieces[[pos[0]-1,pos[1]-2]].white):
				possibleMoves.append([pos[0]-1,pos[1]-2]);
				
	if (pos[0]+2 < 8):
		if (pos[1]+1 < 8):
			if (!b.board[[pos[0]+2,pos[1]+1]].occupied):
				possibleMoves.append([pos[0]+2,pos[1]+1]);
			elif (b.pieces[[pos[0]+2,pos[1]+1]].white):
				possibleMoves.append([pos[0]+2,pos[1]+1]);
		if (pos[1]-1 > -1):
			if (!b.board[[pos[0]+2,pos[1]-1]].occupied):
				possibleMoves.append([pos[0]+2,pos[1]-1]);
			elif (b.pieces[[pos[0]+2,pos[1]-1]].white):
				possibleMoves.append([pos[0]+2,pos[1]-1]);
	if (pos[0]-2 > -1):
		if (pos[1]+1 < 8):
			if (!b.board[[pos[0]-2,pos[1]+1]].occupied):
				possibleMoves.append([pos[0]-2,pos[1]+1]);
			elif (b.pieces[[pos[0]-2,pos[1]+1]].white):
				possibleMoves.append([pos[0]-2,pos[1]+1]);
		if (pos[1]-1 > -1):
			if (!b.board[[pos[0]-2,pos[1]-1]].occupied):
				possibleMoves.append([pos[0]-2,pos[1]-1]);
			elif (b.pieces[[pos[0]-2,pos[1]-1]].white):
				possibleMoves.append([pos[0]-2,pos[1]-1]);
				
	#clear dupes
	var temp = {};
	for move in possibleMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	possibleMoves = temp.keys();
	
	b.showPossible(possibleMoves);
