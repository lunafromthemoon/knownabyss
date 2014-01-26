package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	
	public class Document extends MovieClip 
	{
		
		public static var menuScene:MovieClip;
		public static var gameScene:GameScene;
		
		public function Document() 
		{		
			trace("Document");
			addEventListener("GameStart", startGame);
			dispatchEvent(new Event("GameStart"));
		}
		
		function startGame(e:Event)
		{
			gameScene = new GameScene();
			addChild(gameScene);
			
		}
	}
	
}
