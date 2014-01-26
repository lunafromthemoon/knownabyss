package 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.display.Bitmap;
	
	public class MessageBox extends MovieClip
	{
		
		public var bitMap:Bitmap;
		var destroyDelay:int;
		var delay:int = 2;
		var messages:Array = new Array();
		var numbah:int=0;
		
		public function MessageBox(messagesArray:Array, messageNumber:int, duration:int) 
		{
			super();
			messages = messagesArray;
			bitMap = new Bitmap();
			bitMap = messagesArray[messageNumber];
			trace(bitMap.x);
			bitMap.alpha = 0;
			destroyDelay = duration;
			numbah = messageNumber;
			addChild(bitMap);
			trace(bitMap.x, bitMap.y);
		}
		
		public function showMessage():void
		{
			var showTween:Tween = new Tween(bitMap, "alpha", Regular.easeOut, 0, 0.6, delay, true);
			var destroyTimer:Timer = new Timer(1000, delay + destroyDelay);
			destroyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeFromParent);
			
			destroyTimer.start();
			showTween.start();
		}
		
		function removeFromParent(e:TimerEvent):void
		{
			var hideTween:Tween = new Tween(bitMap, "alpha", Regular.easeOut, 0.6, 0, delay, true);
			hideTween.addEventListener(TweenEvent.MOTION_FINISH, kill);
		}
		
		function kill(e:TweenEvent)
		{
			parent.removeChild(this);
		}
	}
}