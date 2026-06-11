extends TextureButton

var pos;
var possibleMoves = [];
var guardedMoves = [];
var white = true;
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
	b.showPossible(possibleMoves);

func findPossibleMoves(pieces, board, checkOthers):
	guardedMoves.clear();
	possibleMoves.clear();
	
	#diagonal checks
		#down-right
	for i in range(8):
		if (pos[0]+(i+1) < 8 and pos[1]+(i+1) < 8):
			if (!board[[pos[0]+(i+1), pos[1]+(i+1)]].occupied):
				possibleMoves.append([pos[0]+(i+1), pos[1]+(i+1)]);
			elif (!pieces[[pos[0]+(i+1), pos[1]+(i+1)]].white):
				possibleMoves.append([pos[0]+(i+1), pos[1]+(i+1)]);
				break;
			else:
				guardedMoves.append([pos[0]+(i+1), pos[1]+(i+1)]);
				break;
		else:
			break;

		#down-left
	for i in range(8):
		if (pos[0]-(i+1) > -1 and pos[1]+(i+1) < 8):
			if (!board[[pos[0]-(i+1), pos[1]+(i+1)]].occupied):
				possibleMoves.append([pos[0]-(i+1), pos[1]+(i+1)]);
			elif (!pieces[[pos[0]-(i+1), pos[1]+(i+1)]].white):
				possibleMoves.append([pos[0]-(i+1), pos[1]+(i+1)]);
				break;
			else:
				guardedMoves.append([pos[0]-(i+1), pos[1]+(i+1)]);
				break;
		else:
			break;
			
		#up-left
	for i in range(8):
		if (pos[0]-(i+1) > -1 and pos[1]-(i+1) > -1):
			if (!board[[pos[0]-(i+1), pos[1]-(i+1)]].occupied):
				possibleMoves.append([pos[0]-(i+1), pos[1]-(i+1)]);
			elif (!pieces[[pos[0]-(i+1), pos[1]-(i+1)]].white):
				possibleMoves.append([pos[0]-(i+1), pos[1]-(i+1)]);
				break;
			else:
				guardedMoves.append([pos[0]-(i+1), pos[1]-(i+1)]);
				break;
		else:
			break;
			
		#up-right
	for i in range(8):
		if (pos[0]+(i+1) < 8 and pos[1]-(i+1) > -1):
			if (!board[[pos[0]+(i+1), pos[1]-(i+1)]].occupied):
				possibleMoves.append([pos[0]+(i+1), pos[1]-(i+1)]);
			elif (!pieces[[pos[0]+(i+1), pos[1]-(i+1)]].white):
				possibleMoves.append([pos[0]+(i+1), pos[1]-(i+1)]);
				break;
			else:
				guardedMoves.append([pos[0]+(i+1), pos[1]-(i+1)]);
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
	
	
	#if (checkOthers):
		#var holdPos = pos;
		#var holdBoard = board;
		#var holdPieces = pieces;
		#var tempPos;
		#var tempBoard;
		#var tempPieces;
		#for move in possibleMoves:
			#tempPos = move;
			#tempBoard = board;
			#tempPieces = pieces;
			#
			#tempBoard[pos].occupied = false;
			#tempPieces.erase(pos);
			#tempBoard[tempPos].occupied = true;
			#tempPieces[tempPos] = self
			#for piece in b.blackPieces:
				#piece.findPossibleMoves(tempPieces, tempBoard, false);
				#for bMove in piece.possibleMoves:
					#if (tempBoard[bMove].occupied):
						#if (tempPieces[bMove].val == 1000):
							#possibleMoves.erase(move);
				#for bMove in piece.guardedMoves:
					#if (tempBoard[bMove].occupied):
						#if (tempPieces[bMove].val == 1000 and tempPieces[bMove].white):
							#possibleMoves.erase(move);
							#
		#
		#pos = holdPos;
		#board = holdBoard;
		#pieces = holdPieces;
		#
		#for posi in pieces.keys():
			#if (pieces.get(posi) == self):
				#board[posi].occupied = false;
				#pieces.erase(posi);
				#
		#pieces[pos] = self;
		#board[pos].occupied = true;
