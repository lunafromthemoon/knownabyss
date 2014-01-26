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
		
		public function GameScene() {			
			bitmapManager.addEventListener(BitmapManager.TILES_LOADED,startGame);
			
			//var charA:Character = new Character(characters[0].getName(),characters[0].getEvol());
			
			backGround = new BitmapData(800, 600, true, 0x00FF0000);			
			canvas = backGround.clone();			
			var canvasBC:Bitmap = new Bitmap(canvas);			
			addChild(canvasBC);
			
			
			for(var i:int = 0;i<characters.length;i++){
				this.addChild(characters[i]);				
				characters[i].addEventListener("evolve",clickOnChar);
			}
			
			bitmapManager.loadAll();
		}
		
		public function clickOnChar(e:Event) {
			trace(e.target.getName());
			//hole.addEvolution(e.target as Character);
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
			
			var char = characters[0];
			characters[0] = characters[3];
			characters[3] = char;
			
			addEventListener(Event.ENTER_FRAME, gameLoop);
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
		}
	}
}