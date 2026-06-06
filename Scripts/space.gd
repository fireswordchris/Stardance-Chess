extends Button

var x;
var y;

var white;
var offset = 100;

var occupied = false;
var b;

var tintAmount = .1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tint():
	if (white):
		$ColorRect.color = b.white;
		$ColorRect.color = Color($ColorRect.color.r-tintAmount,$ColorRect.color.g,$ColorRect.color.b-tintAmount);
	else:
		$ColorRect.color = b.black;
		$ColorRect.color = Color($ColorRect.color.r-tintAmount,$ColorRect.color.g,$ColorRect.color.b-tintAmount);

func unTint():
	if (white):
		$ColorRect.color = b.white;
	else:
		$ColorRect.color = b.black;

func _on_pressed():
	b.unShowPossible();
	if (b.selectedPiece != null):
		if ([x,y] in b.selectedPiece.possibleMoves):
			if (occupied):
				var taken = b.pieces[[x,y]];
				b.pieces.erase([x,y]);
				taken.free();
				
			var piece = b.selectedPiece;
			
			b.board[piece.pos].occupied = false;
			b.pieces.erase(piece.pos);
			piece.pos = [x,y];
			b.pieces[piece.pos] = piece;
			
			piece.set_position(Vector2(x*100+offset,y*100));
			occupied = true;
			
			if ((y == 7 or y == 0) and piece.type == "pawn"):
				piece.evolve();

		b.selectedPiece.selected = false;
		b.selectedPiece = null;
