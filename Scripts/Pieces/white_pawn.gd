extends TextureButton

var pos;
var possibleMoves = [];
var guardedMoves = [];
var white = true;
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
	b.showPossible(possibleMoves);
	
	
func findPossibleMoves(pieces, board, checkOthers):
	guardedMoves.clear();
	possibleMoves.clear();
	
	if (pos[1] == 6 and !board[[pos[0],4]].occupied and !board[[pos[0],pos[1]-1]].occupied):
		possibleMoves.append([pos[0],4]);
	
	if (pos[1]-1 > -1):
		if (!board[[pos[0],pos[1]-1]].occupied):
			possibleMoves.append([pos[0],pos[1]-1]);
		
		if (pos[0] > 0):
			if (board[[pos[0]-1,pos[1]-1]].occupied and !pieces[[pos[0]-1,pos[1]-1]].white):
				possibleMoves.append([pos[0]-1,pos[1]-1]);
			else:
				guardedMoves.append([pos[0]-1,pos[1]-1]);
		if (pos[0] < 7):
			if (board[[pos[0]+1,pos[1]-1]].occupied and !pieces[[pos[0]+1,pos[1]-1]].white):
				possibleMoves.append([pos[0]+1,pos[1]-1]);
			else:
				guardedMoves.append([pos[0]+1,pos[1]-1]);
			
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

func evolve():
	b.pieces.erase(self);
	b.whitePieces.erase(self);
	$"Evolve Menu".visible = true;


func _on_queen_pressed():
	var whiteQueen = b.wQueen.instantiate();
	whiteQueen.b = b;
	
	whiteQueen.set_position(Vector2(pos[0]*100+b.offset,pos[1]*100));
	whiteQueen.pos = pos;
	
	b.pieces[whiteQueen.pos] = whiteQueen;
	b.get_parent().add_child.call_deferred(whiteQueen);
	
	queue_free();


func _on_rook_pressed():
	var rook = b.wRook.instantiate();
	rook.b = b;
	
	rook.set_position(Vector2(pos[0]*100+b.offset, pos[1]*100));
	rook.pos = pos;

	b.pieces[rook.pos] = rook;
	b.get_parent().add_child.call_deferred(rook);
	
	queue_free();


func _on_bishop_pressed():
	var bishop = b.wBishop.instantiate();
	bishop.b = b;
		
	bishop.set_position(Vector2(pos[0]*100+b.offset,pos[1]*100));
	bishop.pos = pos;
		
	b.pieces[bishop.pos] = bishop;
	b.get_parent().add_child.call_deferred(bishop);
	
	queue_free();

func _on_knight_pressed():
	var knight = b.wKnight.instantiate();
	knight.b = b;
	
	knight.set_position(Vector2(pos[0]*100+b.offset, pos[1]*100));
	knight.pos = pos;

	b.pieces[knight.pos] = knight;
	b.get_parent().add_child.call_deferred(knight);
	
	queue_free();
