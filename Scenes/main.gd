extends Node

var board;
var points = 0;
var won = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func computerMove():
	var pieces = board.pieces;
	var blackPieces = board.blackPieces;
	var whitePieces = board.whitePieces;
	var spaces = board.board;
	var unsolveable = [0];
	
	var whitePossibleMoves = {};
	var whiteGuardedMoves = {};
	var blackPossibleMoves = {};
	var blackGuardedMoves = {};
	
	var highestVal = 0;
	var bestMove = [-1,-1];
	var bestPiece;
	var typeMove;
	var ownKingPossible = false;
	var dangerPiece;
	var dangerSpot;
	
	for piece in pieces.values():
		piece.findPossibleMoves(pieces, spaces, true);
		if (piece.white):
			for guardedMove in piece.guardedMoves:
				whiteGuardedMoves[guardedMove] = piece;
		else:
			for guardedMove in piece.guardedMoves:
				blackGuardedMoves[guardedMove] = piece;

	for piece in blackPieces:
		for posMove in piece.possibleMoves:
			if (spaces[posMove].occupied):
				if (pieces[posMove].val > highestVal):
					if (posMove not in whiteGuardedMoves):
						highestVal = pieces[posMove].val;
						bestMove = posMove;
						bestPiece = piece;
						typeMove = "take";
					elif (pieces[posMove].val-piece.val > highestVal):
						highestVal = pieces[posMove].val;
						bestMove = posMove;
						bestPiece = piece;
						typeMove = "take";
					elif (pieces[posMove].val > piece.val and posMove in blackGuardedMoves and whiteGuardedMoves[posMove].val+pieces[posMove].val-piece.val > highestVal):
						highestVal = pieces[posMove].val;
						bestMove = posMove;
						bestPiece = piece;
						typeMove = "take";
			blackPossibleMoves[posMove] = piece;

	for piece in whitePieces:
		for posMove in piece.possibleMoves:
			if (spaces[posMove].occupied):
				if (pieces[posMove].val > highestVal):
					if (piece.val < pieces[posMove].val):
						highestVal = pieces[posMove].val;
						dangerPiece = piece;
						dangerSpot = posMove;
						bestPiece = pieces[posMove];
						typeMove = "defend";
					else:
						if (posMove not in blackGuardedMoves):
							highestVal = pieces[posMove].val;
							dangerPiece = piece;
							dangerSpot = posMove;
							bestPiece = pieces[posMove];
							typeMove = "defend";
			whitePossibleMoves[posMove] = piece;
	
	if (highestVal == 0):
		var decent = false;
		while (!decent):
			bestPiece = (randi() % len(blackPieces))
			var tempPieces = blackPieces;
			while (len(blackPieces[bestPiece].possibleMoves) == 0):
				bestPiece = (randi() % len(blackPieces))
				tempPieces.erase(bestPiece);
				
			bestMove = tempPieces[bestPiece].possibleMoves[(randi() % len(tempPieces[bestPiece].possibleMoves))]
			bestPiece = tempPieces[bestPiece];
			
			var tempMoves = blackPossibleMoves;
			tempMoves.erase(bestPiece);
			
			if (bestMove in whiteGuardedMoves or bestMove in whitePossibleMoves): #if the spot is covered by a white piece
				if (bestMove in tempMoves): #but it is also covered by a black piece (not the one moving)
					var bad = false;
				
					for piece in whitePieces:
						if (bestMove in piece.possibleMoves and piece.val < bestPiece.val): #if the piece that can take it is worth less
							bad = true;
							break;
						elif (spaces[bestMove].occupied):
							if (bestMove in piece.guardedMoves and pieces[bestMove].val < bestPiece.val): #or the piece being traded is worth less
								bad = true;
								break;
						elif (piece.val == 1):
							if (bestMove in piece.guardedMoves):
								bad = true;
								break;
					if (!bad):
						decent = true;
			else: 
				decent = true;
	
	if (typeMove == "defend"):
		var tempMoves = blackPossibleMoves;
		tempMoves.erase(bestPiece);
		var solved = false;
		var dodging = false;
		
		for move in bestPiece.possibleMoves:
			if (dangerPiece.val >= bestPiece.val and move == dangerPiece.pos):
				bestMove = move;
				typeMove = "take";
				solved = true;
				break;
			elif (move not in whitePossibleMoves and move not in whiteGuardedMoves):
				bestMove = move;
				solved = true;
				dodging = true;
				break;
			elif (move in tempMoves):
				for piece in whitePieces:
					if (move in piece.possibleMoves):
						if (bestPiece.val <= piece.val):
							bestMove = move;
							bestMove = move;
							solved = true;
					elif (move in piece.guardedMoves and spaces[move].occupied):
						if (pieces[move].val >= bestPiece.val):
							bestMove = move;
							solved = true;
							bestMove = move;
				if (solved):
					break;
		if ((dodging and dangerPiece.pos in tempMoves) or (!solved and dangerPiece.pos in tempMoves)):
			var bestVal = 0;
			for piece in blackPieces:
				if (dangerPiece.pos in piece.possibleMoves):
					if (dangerPiece.pos in whiteGuardedMoves):
						if (piece.val <= dangerPiece.val and dangerPiece.val - piece.val > bestVal):
							bestMove = dangerPiece.pos;
							bestPiece = piece;
							typeMove = "take";
							solved = true;
							dodging = false;
							bestVal = dangerPiece.val - piece.val;
					else:
						bestMove = dangerPiece.pos;
						bestPiece = piece;
						typeMove = "take";
						solved = true;
						dodging = false;
						bestVal = dangerPiece.val;
		if (!solved):
			unsolveable = [0, dangerSpot];
			while (unsolveable[0] != -1):
				unsolveable = recheck(unsolveable, pieces, blackPieces, whitePieces, spaces, blackPossibleMoves, whitePossibleMoves, blackGuardedMoves, whiteGuardedMoves);
				if (str(unsolveable[0]) == "gave up"):
					break;
			if (str(unsolveable[0]) == "gave up"):
				var decent = false;
				while (!decent):
					bestPiece = (randi() % len(blackPieces))
					var tempPieces = blackPieces;
					while (len(blackPieces[bestPiece].possibleMoves) == 0):
						bestPiece = (randi() % len(blackPieces))
						tempPieces.erase(bestPiece);
						
					bestMove = tempPieces[bestPiece].possibleMoves[(randi() % len(tempPieces[bestPiece].possibleMoves))]
					bestPiece = tempPieces[bestPiece];
					
					tempMoves = blackPossibleMoves;
					tempMoves.erase(bestPiece);
					
					if (bestMove in whiteGuardedMoves or bestMove in whitePossibleMoves): #if the spot is covered by a white piece
						if (bestMove in tempMoves): #but it is also covered by a black piece (not the one moving)
							var bad = false;
						
							for piece in whitePieces:
								if (bestMove in piece.possibleMoves and piece.val < bestPiece.val): #if the piece that can take it is worth less
									bad = true;
									break;
								elif (spaces[bestMove].occupied):
									if (bestMove in piece.guardedMoves and pieces[bestMove].val < bestPiece.val): #or the piece being traded is worth less
										bad = true;
										break;
								elif (piece.val == 1):
									if (bestMove in piece.guardedMoves):
										bad = true;
										break;
							if (!bad):
								decent = true;
					else: 
						decent = true;
			else:
				bestPiece = unsolveable[1];
				bestMove = unsolveable[2];
				typeMove = unsolveable[3];
			
	if (spaces[bestMove].occupied):
		typeMove = "take";
	
	while (typeMove == "take"):
		if (typeMove == "take"):
			if (bestMove not in whiteGuardedMoves or board.pieces[bestMove].val >= bestPiece.val):
				var taken = board.pieces[bestMove];
				board.pieces.erase(bestMove);
				board.whitePieces.erase(taken);
				points += taken.val;
				if (points >= 1000):
					print("player lost");
				taken.queue_free();
				break;
			else:
				unsolveable = [0, bestMove];
				while (unsolveable[0] != -1):
					unsolveable = recheck(unsolveable, pieces, blackPieces, whitePieces, spaces, blackPossibleMoves, whitePossibleMoves, blackGuardedMoves, whiteGuardedMoves);
					if (str(unsolveable[0]) == "gave up"):
						break;
				if (str(unsolveable[0]) == "gave up"):
					var taken = board.pieces[bestMove];
					board.pieces.erase(bestMove);
					board.whitePieces.erase(taken);
					points += taken.val;
					if (points >= 1000):
						print("player lost");
					taken.queue_free();
					break;
				else:
					bestPiece = unsolveable[1];
					bestMove = unsolveable[2];
					typeMove = unsolveable[3];
			
	board.board[bestPiece.pos].occupied = false;
	board.pieces.erase(bestPiece.pos);
	
	if (bestPiece.val == 1000):
		if (bestMove[0] == bestPiece.pos[0]+2):
			var rook = board.pieces[[7,bestMove[1]]];
			board.board[rook.pos].occupied = false;
			board.pieces.erase(rook.pos);
			rook.pos = [bestPiece.pos[0]+1,bestMove[1]];
			board.pieces[rook.pos] = rook;
			board.board[rook.pos].occupied = true;
			rook.set_position(Vector2(rook.pos[0]*100+board.offset,rook.pos[1]*100));
			rook.findPossibleMoves(board.pieces, board.board, true);
					
		elif (bestMove[0] == bestPiece.pos[0]-2):
			var rook = board.pieces[[0,bestMove[1]]];
			board.board[rook.pos].occupied = false;
			board.pieces.erase(rook.pos);
			rook.pos = [bestPiece.pos[0]-1,bestMove[1]];
			board.pieces[rook.pos] = rook;
			board.board[rook.pos].occupied = true;
			rook.set_position(Vector2(rook.pos[0]*100+board.offset,rook.pos[1]*100));
			rook.findPossibleMoves(board.pieces, board.board, true);
	
	bestPiece.set_position(Vector2(bestMove[0]*100+board.offset,bestMove[1]*100));
	bestPiece.pos = bestMove;
	
	if (bestPiece.val == 5 or bestPiece.val == 1000):
		bestPiece.notMoved = false;
		
	if (bestPiece.val == 1000):
		board.bKingPos = bestMove;
	
	board.pieces[bestMove] = bestPiece;
	board.board[bestMove].occupied = true;
	
	bestPiece.findPossibleMoves(board.pieces, board.board, true);
	
	if (points < 1000):
		board.playerTurn = true;
	else:
		won = true;

func recheck(unsolveable, pieces, blackPieces, whitePieces, spaces, blackPossibleMoves, whitePossibleMoves, blackGuardedMoves, whiteGuardedMoves):
	var highestVal = 0;
	var bestMove = [-1,-1];
	var bestPiece;
	var typeMove;
	var ownKingPossible = false;
	var dangerPiece;
	var dangerSpot;
	var solved = false;

	for piece in blackPieces:
		for posMove in piece.possibleMoves:
			if (spaces[posMove].occupied):
				if (pieces[posMove].val > highestVal):
					highestVal = pieces[posMove].val;
					bestMove = posMove;
					bestPiece = piece;
					typeMove = "take";
					solved = true;

	for piece in whitePieces:
		for posMove in piece.possibleMoves:
			if (posMove not in unsolveable):
				if (spaces[posMove].occupied):
					if (pieces[posMove].val > highestVal):
						if (piece.val <= pieces[posMove].val):
							highestVal = pieces[posMove].val;
							dangerPiece = piece;
							dangerSpot = posMove;
							bestPiece = pieces[posMove];
							typeMove = "defend";
						else:
							if (posMove not in blackGuardedMoves):
								highestVal = pieces[posMove].val;
								dangerPiece = piece;
								dangerSpot = posMove;
								bestPiece = pieces[posMove];
								typeMove = "defend";
								
	if (typeMove == "defend"):
		var tempMoves = blackPossibleMoves;
		tempMoves.erase(bestPiece);
		solved = false;
		var dodging = false;
		
		for move in bestPiece.possibleMoves:
			if (dangerPiece.val >= bestPiece.val and move == dangerPiece.pos):
				bestMove = move;
				typeMove = "take";
				solved = true;
				break;
			elif (move not in whitePossibleMoves):
				bestMove = move;
				solved = true;
				dodging = true;
				break;
			elif (move in tempMoves and dangerPiece.val >= bestPiece.val):
				bestMove = move;
				solved = true;
				break;
		if ((dodging and dangerPiece.pos in tempMoves) or (!solved and dangerPiece.pos in tempMoves)):
			var bestVal = 0;
			for piece in blackPieces:
				if (dangerPiece.pos in piece.possibleMoves):
					if (dangerPiece.pos in whiteGuardedMoves):
						if (piece.val <= dangerPiece.val and dangerPiece.val - piece.val > bestVal):
							bestMove = dangerPiece.pos;
							bestPiece = piece;
							typeMove = "take";
							solved = true;
							dodging = false;
							bestVal = dangerPiece.val - piece.val;
					else:
						bestMove = dangerPiece.pos;
						bestPiece = piece;
						typeMove = "take";
						solved = true;
						dodging = false;
						bestVal = dangerPiece.val;
		if (!solved):
			unsolveable.append(dangerSpot);
			return unsolveable;
	
	if (solved):
		return [-1,bestPiece,bestMove,typeMove];
		
	return ["gave up"];
