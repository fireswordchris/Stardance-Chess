extends TextureButton

var pos;
var possibleMoves = [];
var guardedMoves = [];
var white = true;
var pieces;
var b;
var selected = false;
var val = 1000;

var blockedMoves = [];
var notMoved = true;
var castlePos = "no";
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
	blockedMoves.clear();
	guardedMoves.clear();
	possibleMoves.clear();
	
	if (checkOthers):
		for piece in b.blackPieces:
			if (piece.val == 1000):
				piece.findPossibleMoves(pieces, board, false);
			else:
				piece.findPossibleMoves(pieces, board, false);
			if (piece.val != 1):
				for move in piece.possibleMoves:
					if (move != piece.pos):
						blockedMoves.append(move);
			else:
				for move in piece.possibleMoves:
					if (move != [piece.pos[0],piece.pos[1]+1] and move != [piece.pos[0],piece.pos[1]+2] and move != piece.pos):
						blockedMoves.append(move);
			for move in piece.guardedMoves:
				blockedMoves.append(move);
	else:
		for piece in b.blackPieces:
			if (piece.val != 1):
				for move in piece.possibleMoves:
					if (move != piece.pos):
						blockedMoves.append(move);
			else:
				for move in piece.possibleMoves:
					if (move != [piece.pos[0],piece.pos[1]+1] and move != [piece.pos[0],piece.pos[1]+2] and move != piece.pos):
						blockedMoves.append(move);
			for move in piece.guardedMoves:
				blockedMoves.append(move);
	
			
	var temp = {};
	for move in blockedMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	blockedMoves = temp.keys();
	
	if (pos[0]+1 < 8):
		if (pos[1]+1 < 8):
			if ([pos[0]+1,pos[1]+1] not in blockedMoves):
				if (!board[[pos[0]+1,pos[1]+1]].occupied):
					possibleMoves.append([pos[0]+1,pos[1]+1]);
				elif (!pieces[[pos[0]+1,pos[1]+1]].white):
					possibleMoves.append([pos[0]+1,pos[1]+1]);
				else:
					guardedMoves.append([pos[0]+1,pos[1]+1]);
		if (pos[1]-1 > -1):
			if ([pos[0]+1,pos[1]-1] not in blockedMoves):
				if (!board[[pos[0]+1,pos[1]-1]].occupied):
					possibleMoves.append([pos[0]+1,pos[1]-1]);
				elif (!pieces[[pos[0]+1,pos[1]-1]].white):
					possibleMoves.append([pos[0]+1,pos[1]-1]);
				else:
					guardedMoves.append([pos[0]+1,pos[1]-1]);
		if ([pos[0]+1,pos[1]] not in blockedMoves):
			if (!board[[pos[0]+1,pos[1]]].occupied):
				possibleMoves.append([pos[0]+1,pos[1]]);
			elif (!pieces[[pos[0]+1,pos[1]]].white):
				possibleMoves.append([pos[0]+1,pos[1]]);
			else:
				guardedMoves.append([pos[0]+1,pos[1]]);
	if (pos[0]-1 > -1):
		if (pos[1]+1 < 8):
			if ([pos[0]-1,pos[1]+1] not in blockedMoves):
				if (!board[[pos[0]-1,pos[1]+1]].occupied):
					possibleMoves.append([pos[0]-1,pos[1]+1]);
				elif (!pieces[[pos[0]-1,pos[1]+1]].white):
					possibleMoves.append([pos[0]-1,pos[1]+1]);
				else:
					guardedMoves.append([pos[0]-1,pos[1]+1]);
		if (pos[1]-1 > -1):
			if ([pos[0]-1,pos[1]-1] not in blockedMoves):
				if (!board[[pos[0]-1,pos[1]-1]].occupied):
					possibleMoves.append([pos[0]-1,pos[1]-1]);
				elif (!pieces[[pos[0]-1,pos[1]-1]].white):
					possibleMoves.append([pos[0]-1,pos[1]-1]);
				else:
					guardedMoves.append([pos[0]-1,pos[1]-1]);
		if ([pos[0]-1,pos[1]] not in blockedMoves):
			if (!board[[pos[0]-1,pos[1]]].occupied):
				possibleMoves.append([pos[0]-1,pos[1]]);
			elif (!pieces[[pos[0]-1,pos[1]]].white):
				possibleMoves.append([pos[0]-1,pos[1]]);
			else:
				guardedMoves.append([pos[0]-1,pos[1]]);
	if (pos[1]+1 < 8):
		if ([pos[0],pos[1]+1] not in blockedMoves):
			if (!board[[pos[0],pos[1]+1]].occupied):
				possibleMoves.append([pos[0],pos[1]+1]);
			elif (!pieces[[pos[0],pos[1]+1]].white):
				possibleMoves.append([pos[0],pos[1]+1]);
			else:
				guardedMoves.append([pos[0],pos[1]+1]);
	if (pos[1]-1 > -1):
		if ([pos[0],pos[1]-1] not in blockedMoves):
			if (!board[[pos[0],pos[1]-1]].occupied):
				possibleMoves.append([pos[0],pos[1]-1]);
			elif (!pieces[[pos[0],pos[1]-1]].white):
				possibleMoves.append([pos[0],pos[1]-1]);
			else:
				guardedMoves.append([pos[0],pos[1]-1]);
	
	#clear dupes
	temp = {};
	for move in possibleMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	possibleMoves = temp.keys();
	temp = {};
	for move in guardedMoves:
		if !(move in temp) and move != pos:
			temp[move] = "held";
	guardedMoves = temp.keys();

	if (notMoved):
		castlePos = b.castlePossible("white");
		if (castlePos == "no"):
			pass
		elif (castlePos == "both"):
			possibleMoves.append([2,pos[1]]);
			possibleMoves.append([6,pos[1]]);
		elif (castlePos == "left"):
			possibleMoves.append([2,pos[1]]);
		elif (castlePos == "right"):
			possibleMoves.append([6, pos[1]]);
