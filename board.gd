extends Node2D

var board = [];
var space = preload("res://Scenes/space.tscn");
var black = Color(0.133, 0.133, 0.133, 1.0);
var white = Color(0.869, 0.869, 0.869, 1.0);

var whitePieces = [];
var blackPieces = [];

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

# Called when the node enters the scene tree for the first time.
func _ready():
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
			square.set_position(Vector2(h*100+100,v*100));
			
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
			get_parent().add_child.call_deferred(square);
		w = !w;
		
func setupPieces():
	for i in range(8):
		var pawn = wPawn.instantiate();
		pawn.set_position(Vector2(100*i+150,150));
		get_parent().add_child.call_deferred(pawn);
