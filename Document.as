package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	
	public class Document extends MovieClip {
		
		private var bitmapManager:BitmapManager = new BitmapManager("Animations.xml");
		private var tileSet:BitmapData;
		private var canvas:BitmapData
		private var backGround:BitmapData;
		private var iteration:int = 0;
		private var animations:Array = new Array();
		
		public function Document() {
			var characters:Array = CharacterFactory.createCharacters();
			
			bitmapManager.addEventListener(BitmapManager.TILES_LOADED,startGame);
			
			//var charA:Character = new Character(characters[0].getName(),characters[0].getEvol());
			
			
			backGround = new BitmapData(800, 600, true, 0x00FF0000);			
			canvas = backGround.clone();			
			var canvasBC:Bitmap = new Bitmap(canvas);			
			addChild(canvasBC);
			//characters[0].addEventListener(MouseEvent.CLICK,clickOnChar);
			characters[0].setMask();
			this.addChild(characters[0]);
			bitmapManager.loadAll();	
		}
		
		public function clickOnChar(e:MouseEvent) {
			trace(e.target.getName());
		}
		
		private function startGame(event:Event):void{
			//load bitmaps
			backGround.copyPixels(bitmapManager.getTileSet("Background"),new Rectangle(0,0,800,600),new Point(0,0));
			animations = bitmapManager.getAnimationsFromTileSet("Napoleon");
			//do we need a game loop?
			addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		public function gameLoop(e:Event) {
			canvas.copyPixels(backGround,backGround.rect, new Point(0,0));
			drawCanvas();
		}
		
		private function drawCanvas():void {
			iteration++;
			for(var i:int = 0;i<animations.length;i++){
				var tile:BitmapData = animations[i].getNextFrame();	
				canvas.copyPixels(tile,tile.rect, new Point(50,i*70+50),BitmapManager.getAlphaBitmap(tile.width,tile.height),null,true);
			}
			
		}
	}
	
}
