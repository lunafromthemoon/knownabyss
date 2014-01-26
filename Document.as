package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Document extends MovieClip 
	{
		
		public static var menuScene:MovieClip;
		public static var gameScene:GameScene;
		public var menufadein:Sprite;
		
		public function Document() 
		{	
			gameScene = new GameScene();
			menufadein = new Sprite();
			
			menufadein.graphics.beginFill(0x000000, 1);
			menufadein.graphics.drawRect(0,0,800,600);
			menufadein.graphics.endFill();			

			addChild(gameScene);
			
			addChild(menufadein);
			var timer:Timer = new Timer(3000, 2);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, startFade);	
			timer.start();
		}
		
		function startFade(e:TimerEvent):void
		{
			var tween:Tween = new Tween(menufadein, "alpha", Regular.easeOut, 1, 0.7, 3, true);
			tween.addEventListener(TweenEvent.MOTION_FINISH,allowStart);
			tween.start();
		}
		
		function allowStart(e:Event)
		{
			menufadein.addEventListener(MouseEvent.CLICK, clickOnMenu);
		}
		
		function clickOnMenu(e:Event)
		{
			
			removeChild(menufadein);
			
		}
		
	}
	
}
