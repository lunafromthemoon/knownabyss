package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	public class Document extends MovieClip {
		
		private var bitmapManager:BitmapManager = new BitmapManager("Animations.xml");
		private var tileSet:BitmapData;
		private var canvas:BitmapData
		private var backGround:BitmapData;
		private var iteration:int = 0;
		private var animations:Array = new Array();
		
		public function Document() {
			bitmapManager.addEventListener(BitmapManager.TILES_LOADED,startGame);
			backGround = new BitmapData(640, 480, true, 0x00FF0000);			
			canvas = backGround.clone();			
			var canvasBC:Bitmap = new Bitmap(canvas);			
			addChild(canvasBC);
			bitmapManager.loadAll();	
		}
		
		private function startGame(event:Event):void{
			//load bitmaps
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
