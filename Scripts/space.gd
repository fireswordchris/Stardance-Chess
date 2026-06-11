extends Button

var x;
var y;

var white;
var offset = 100;

var occupied = false;
var b;

var tintAmount = .1
var makeComputerMove = false;
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
	if (b.selectedPiece != null):
		if ([x,y] in b.selectedPiece.possibleMoves and b.playerTurn):
			var piece = b.selectedPiece;
			
			if (occupied):
				var taken = b.pieces[[x,y]];
				if (taken.val == 1000):
					b.playerWin = true;
				b.pieces.erase([x,y]);
				if (taken in b.blackPieces):
					b.blackPieces.erase(taken);
				else:
					b.whitePieces.erase(taken);
				taken.queue_free();
			
			if (piece.val == 1000):
				if (x == piece.pos[0]+2):
					var rook = b.pieces[[7,y]];
					b.board[rook.pos].occupied = false;
					b.pieces.erase(rook.pos);
					rook.pos = [piece.pos[0]+1,y];
					b.pieces[rook.pos] = rook;
					b.board[rook.pos].occupied = true;
					rook.set_position(Vector2(rook.pos[0]*100+offset,rook.pos[1]*100));
					
				elif (x == piece.pos[0]-2):
					var rook = b.pieces[[0,y]];
					b.board[rook.pos].occupied = false;
					b.pieces.erase(rook.pos);
					rook.pos = [piece.pos[0]-1,y];
					b.pieces[rook.pos] = rook;
					b.board[rook.pos].occupied = true;
					rook.set_position(Vector2(rook.pos[0]*100+offset,rook.pos[1]*100));
					
			b.board[piece.pos].occupied = false;
			b.pieces.erase(piece.pos);
			piece.pos = [x,y];
			b.pieces[piece.pos] = piece;
			
			piece.set_position(Vector2(x*100+offset,y*100));
			occupied = true;
			
			if ((y == 7 or y == 0) and piece.val == 1):
				piece.evolve();
			
			if (piece.val == 5 or piece.val == 1000):
				piece.notMoved = false;
			
			if (piece.val == 1000):
				if (piece.white):
					b.wKingPos = piece.pos;
				else:
					b.bKingPos = piece.pos;
			
			b.playerTurn = false;
			makeComputerMove = true;

		b.selectedPiece.selected = false;
		b.selectedPiece = null;
		b.unShowPossible();
		
		if (makeComputerMove):
			b.computerMove();
			makeComputerMove = false;
