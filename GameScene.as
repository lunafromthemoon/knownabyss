package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	public class GameScene extends MovieClip 
	{
		
		private var bitmapManager:BitmapManager = new BitmapManager("Animations.xml");
		private var tileSet:BitmapData;
		private var canvas:BitmapData
		private var backGround:BitmapData;
		private var iteration:int = 0;
		private var animations:Array = new Array();
		var characters:Array = CharacterFactory.createCharacters();
		private var hole:Hole = new Hole();
		private var cursor:Cursor = new Cursor();
		
		public function GameScene() {			
			bitmapManager.addEventListener(BitmapManager.TILES_LOADED,startGame);
			
			//var charA:Character = new Character(characters[0].getName(),characters[0].getEvol());
			
			backGround = new BitmapData(800, 600, true, 0x00FF0000);			
			canvas = backGround.clone();			
			var canvasBC:Bitmap = new Bitmap(canvas);			
			addChild(canvasBC);
			
			bitmapManager.loadAll();
		}
		
		public function clickOnChar(e:Event) {
			trace(e.target.getName());
			//hole.addEvolution(e.target as Character);
			e.target.clickMask.removeEventListener(MouseEvent.MOUSE_OVER, onCharMouseOver);
			e.target.clickMask.removeEventListener(MouseEvent.MOUSE_OUT, onCharMouseOut);
			e.target.removeChild(cursor);
			cursor.draw = false;
			e.target.removeEventListener("evolve",clickOnChar);
		}
		
		private function startGame(event:Event):void{
			//load bitmaps
			backGround.copyPixels(bitmapManager.getTileSet("Background"),new Rectangle(0,0,800,600),new Point(0,0));			
			characters[0].setAnimations( bitmapManager.getAnimationsFromTileSet("Faith"));			
			characters[1].setAnimations( bitmapManager.getAnimationsFromTileSet("Science"));
			characters[2].setAnimations( bitmapManager.getAnimationsFromTileSet("Love"));
			characters[3].setAnimations( bitmapManager.getAnimationsFromTileSet("Wisdom"));
			characters[4].setAnimations( bitmapManager.getAnimationsFromTileSet("Art"));
			characters[5].setAnimations( bitmapManager.getAnimationsFromTileSet("Innocence"));
			characters[0].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionA"),new Point(200,400));
			characters[1].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionB"),new Point(264,400));
			characters[2].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionC"),new Point(328,400));
			
			for (var i:int = 0; i < characters.length; i++)
			{
				characters[i].clickMask.addEventListener(MouseEvent.MOUSE_OVER, onCharMouseOver);
				characters[i].clickMask.addEventListener(MouseEvent.MOUSE_OUT, onCharMouseOut);
			}
			
			var char = characters[0];
			characters[0] = characters[3];
			characters[3] = char;
			
			for(var i:int = 0;i<characters.length;i++){
				this.addChild(characters[i]);				
				characters[i].addEventListener("evolve",clickOnChar);
			}
			
			cursor.setAnimation(bitmapManager.getAnimationsFromTileSet("Cursor")[0]);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		public function onCharMouseOver(me:MouseEvent)
		{
			var char:Character = me.target.parent as Character;
			char.addChild(cursor);
			cursor.draw = true;
			
			
			cursor.setPosition(new Point(char.x + char.currentAnimation.animFrameW/2 - cursor.animation.animFrameW/2, char.y - cursor.animation.animFrameH * 1.5));
		}
		
		public function onCharMouseOut(me:MouseEvent)
		{
			cursor.setPosition(new Point( -50, -50));
			cursor.draw = false;
			(me.target.parent as Character).removeChild(cursor);
		}
		
		public function gameLoop(e:Event) {
			canvas.copyPixels(backGround,backGround.rect, new Point(0,0));
			drawCanvas();
		}
		
		private function drawCanvas():void {
			iteration++;
			for(var i:int = 0;i<characters.length;i++){
				var tile:BitmapData = characters[i].currentAnimation.getNextFrame();			
				canvas.copyPixels(tile, tile.rect, characters[i].getPosition(), BitmapManager.getAlphaBitmap(tile.width, tile.height), null, true);
				if (characters[i].getEvol().getCurrentAnimation()!=null) {
					var tileEvol:BitmapData = characters[i].getEvol().getCurrentAnimation().getNextFrame();			
				canvas.copyPixels(tileEvol, tileEvol.rect, characters[i].getEvol().position, BitmapManager.getAlphaBitmap(tileEvol.width, tileEvol.height), null, true);
				}
			}
			
			if (cursor.draw)
			{
				var tileCursor = cursor.animation.getNextFrame();
				canvas.copyPixels(tileCursor, tileCursor.rect, cursor.getPosition(), BitmapManager.getAlphaBitmap(tileCursor.width, tileCursor.height), null, true);
			}
		}
	}
}