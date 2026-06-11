extends Node2D


var playerWin = false;

var selectedPiece;

var offset = 100;

var board = {};
var tinted = [];
var space = preload("res://Scenes/space.tscn");
var black = Color(0.202, 0.266, 0.236, 1.0);
var white = Color(0.869, 0.869, 0.869, 1.0);

var pieces = {};
var blackPieces = [];
var whitePieces = [];

var wPawn = preload("res://Scenes/Pieces/white_pawn.tscn");
var bPawn = preload("res://Scenes/Pieces/black_pawn.tscn");
var wRook = preload("res://Scenes/Pieces/white_rook.tscn");
var bRook = preload("res://Scenes/Pieces/black_rook.tscn");
var wKnight = preload("res://Scenes/Pieces/white_knight.tscn");
var bKnight = preload("res://Scenes/Pieces/black_knight.tscn");
var wBishop = preload("res://Scenes/Pieces/white_bishop.tscn");
var bBishop = preload("res://Scenes/Pieces/black_bishop.tscn");
var wQueen = preload("res://Scenes/Pieces/white_queen.tscn");
var bQueen = preload("res://Scenes/Pieces/black_queen.tscn");
var wKing = preload("res://Scenes/Pieces/white_king.tscn");
var bKing = preload("res://Scenes/Pieces/black_king.tscn");

var playerTurn = true;

var bKingPos;
var wKingPos;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().board = self;
	
	setupSpaces();
	setupPieces();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setupSpaces():
	var w = true;
	
	for v in range(8):
		for h in range(8):
			var square = space.instantiate();
			square.set_position(Vector2(h*100+offset,v*100));
			square.b = self;
			
			if (w):
				square.get_child(0).color = white;
			else:
				square.get_child(0).color = black;
			
			square.x = h;
			square.y = v;
			square.white = w;
			
			if (v <= 1 or v >= 6):
				square.occupied = true;
			
			w = !w;
			board[[square.x,square.y]] = square;
			get_parent().add_child.call_deferred(square);
		w = !w;
		
func setupPieces():
	pawns();
	bishops();
	knights();
	rooks();
	queens();
	kings();
	
	for piece in pieces.values():
		piece.findPossibleMoves(pieces, board, true);
	
func pawns():
	for i in range(8):
		var pawn = wPawn.instantiate();
		pawn.b = self;
		
		pawn.set_position(Vector2(100*i+offset,600));
		pawn.pos = [i,6]
		
		get_parent().add_child.call_deferred(pawn);
		pieces[pawn.pos] = pawn;
		whitePieces.append(pawn);
		
		
	for i in range(8):
		var pawn = bPawn.instantiate();
		pawn.b = self;
		
		pawn.set_position(Vector2(100*i+offset,100));
		pawn.pos = [i,1];
		
		get_parent().add_child.call_deferred(pawn);
		pieces[pawn.pos] = pawn;
		blackPieces.append(pawn);
		
func bishops():
	for i in range(2):
		var bishop = wBishop.instantiate();
		bishop.b = self;
		
		if (i == 0):
			bishop.set_position(Vector2(200+offset, 700));
		else:
			bishop.set_position(Vector2(500+offset,700));
		bishop.pos = [roundi((bishop.get_position().x-offset)/100), 7];
		
		pieces[bishop.pos] = bishop;
		whitePieces.append(bishop);
		get_parent().add_child.call_deferred(bishop);
		
		
	for i in range(2):
		var bishop = bBishop.instantiate();
		bishop.b = self;
		
		if (i == 0):
			bishop.set_position(Vector2(200+offset, 0));
		else:
			bishop.set_position(Vector2(500+offset,0));
		bishop.pos = [roundi((bishop.get_position().x-offset)/100), 0];
		
		pieces[bishop.pos] = bishop;
		blackPieces.append(bishop);
		get_parent().add_child.call_deferred(bishop);
		
func knights():
	for i in range(2):
		var knight = wKnight.instantiate();
		knight.b = self;
		
		if (i == 0):
			knight.set_position(Vector2(100+offset, 700));
		else:
			knight.set_position(Vector2(600+offset,700));
		knight.pos = [roundi((knight.get_position().x-offset)/100),7];

		pieces[knight.pos] = knight;
		whitePieces.append(knight);
		get_parent().add_child.call_deferred(knight);
		
		
	for i in range(2):
		var knight = bKnight.instantiate();
		knight.b = self;
		
		if (i == 0):
			knight.set_position(Vector2(100+offset, 0));
		else:
			knight.set_position(Vector2(600+offset,0));
		knight.pos = [roundi((knight.get_position().x-offset)/100),0];
		
		pieces[knight.pos] = knight;
		blackPieces.append(knight);
		get_parent().add_child.call_deferred(knight);
		
func rooks():
	for i in range(2):
		var rook = wRook.instantiate();
		rook.b = self;
		
		if (i == 0):
			rook.set_position(Vector2(offset, 700));
		else:
			rook.set_position(Vector2(700+offset,700));
		rook.pos = [roundi((rook.get_position().x-offset)/100), 7];

		pieces[rook.pos] = rook;
		whitePieces.append(rook);
		get_parent().add_child.call_deferred(rook);
		
	
	for i in range(2):
		var rook = bRook.instantiate();
		rook.b = self;
		
		if (i == 0):
			rook.set_position(Vector2(offset, 0));
		else:
			rook.set_position(Vector2(700+offset,0));
		rook.pos = [roundi((rook.get_position().x-offset)/100), 0];
		
		pieces[rook.pos] = rook;
		blackPieces.append(rook);
		get_parent().add_child.call_deferred(rook);
		
func queens():
	var whiteQueen = wQueen.instantiate();
	whiteQueen.b = self;
	
	whiteQueen.set_position(Vector2(300+offset,700));
	whiteQueen.pos = [3,7];
	
	pieces[whiteQueen.pos] = whiteQueen;
	whitePieces.append(whiteQueen);
	get_parent().add_child.call_deferred(whiteQueen);
	
	
	
	var blackQueen = bQueen.instantiate();
	blackQueen.b = self;
	
	blackQueen.set_position(Vector2(300+offset,0));
	blackQueen.pos = [3,0];
	
	pieces[blackQueen.pos] = blackQueen;
	blackPieces.append(blackQueen);
	get_parent().add_child.call_deferred(blackQueen);
	
func kings():
	var whiteKing = wKing.instantiate();
	whiteKing.b = self;
	
	whiteKing.set_position(Vector2(400+offset,700));
	whiteKing.pos = [4,7];
	wKingPos = whiteKing.pos;
	
	pieces[whiteKing.pos] = whiteKing;
	whitePieces.append(whiteKing);
	get_parent().add_child.call_deferred(whiteKing);
	
	
	var blackKing = bKing.instantiate();
	blackKing.b = self;
	
	blackKing.set_position(Vector2(400+offset,0));
	blackKing.pos = [4,0];
	bKingPos = blackKing.pos;
	
	pieces[blackKing.pos] = blackKing;
	blackPieces.append(blackKing);
	get_parent().add_child.call_deferred(blackKing);
	

func showPossible(spaces):
	unShowPossible();
	tinted.clear();
	
	for space in spaces:
		board[space].tint();
		
	tinted = spaces;
		
func unShowPossible():
	for space in tinted:
		board[space].unTint();

func computerMove():
	for piece in whitePieces:
		if !pieces.has(piece):
			pieces[piece.pos] = piece;
	for piece in blackPieces:
		if (!pieces.has(piece)):
			pieces[piece.pos] = piece;
	
	if (!playerWin):
		$"Timer".start();
		await $"Timer".timeout;
		get_parent().computerMove();
	else:
		print("player win");

func castlePossible(side):
	var leftRookPossible = false;
	var rightRookPossible = false;

	if (side == "black"):
		for piece in blackPieces:
			if (piece.val == 5):
				if (piece.notMoved):
					if (piece.pos[0] == 0):
						leftRookPossible = true;
					else:
						rightRookPossible = true;
					
		if (leftRookPossible):
			for piece in pieces.values():
				if (piece.pos == [1,0] or piece.pos == [2,0] or piece.pos == [3,0]):
					leftRookPossible = false;
					break;
				if (piece.white):
					if ([1,0] in piece.possibleMoves or [2,0] in piece.possibleMoves or [3,0] in piece.possibleMoves):
						leftRookPossible = false;
						break;
					elif ([1,0] in piece.guardedMoves or [2,0] in piece.guardedMoves or [3,0] in piece.guardedMoves):
						leftRookPossible = false;
						break;
		if (rightRookPossible):
			for piece in pieces.values():
				if (piece.pos == [5,0] or piece.pos == [6,0]):
					rightRookPossible = false;
					break;
				if (piece.white):
					if ([5,0] in piece.possibleMoves or [6,0] in piece.possibleMoves):
						rightRookPossible = false;
						break;
					elif ([5,0] in piece.guardedMoves or [6,0] in piece.guardedMoves):
						rightRookPossible = false;
						break;
	else:
		for piece in whitePieces:
			if (piece.val == 5):
				if (piece.notMoved):
					if (piece.pos[0] == 0):
						leftRookPossible = true;
					else:
						rightRookPossible = true;
					
		if (leftRookPossible):
			for piece in pieces.values():
				if (piece.pos == [1,7] or piece.pos == [2,7] or piece.pos == [3,7]):
					leftRookPossible = false;
					break;
				if (!piece.white):
					if ([1,7] in piece.possibleMoves or [2,7] in piece.possibleMoves or [3,7] in piece.possibleMoves):
						leftRookPossible = false;
						break;
					elif ([1,7] in piece.guardedMoves or [2,7] in piece.guardedMoves or [3,7] in piece.guardedMoves):
						leftRookPossible = false;
						break;
		if (rightRookPossible):
			for piece in pieces.values():
				if (piece.pos == [5,7] or piece.pos == [6,7]):
					rightRookPossible = false;
					break;
				if (!piece.white):
					if ([5,7] in piece.possibleMoves or [6,7] in piece.possibleMoves):
						rightRookPossible = false;
						break;
					elif ([5,7] in piece.guardedMoves or [6,7] in piece.guardedMoves):
						rightRookPossible = false;
						break;
	
	if (leftRookPossible and rightRookPossible):
		return "both";
	elif (leftRookPossible):
		return "left";
	elif (rightRookPossible):
		return "right";
	else:
		return "no";
