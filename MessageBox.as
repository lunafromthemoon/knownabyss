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
		var isShowing:Boolean = false;
		
		public function MessageBox(messagesArray:Array) 
		{
			super();
			messages = messagesArray;
		}
		
		public function showMessage(messageNumber:int, duration:int):void
		{
			if (isShowing)
			{
				this.removeChild(bitMap);
			}
			isShowing = true;
			bitMap = messages[messageNumber - 1];
			trace(bitMap.x, bitMap.y);
			this.addChild(bitMap);
			bitMap.alpha = 0;
			var showTween:Tween = new Tween(bitMap, "alpha", Regular.easeOut, 0, 1, delay, true);
			var destroyTimer:Timer = new Timer(1000, delay + duration);
			destroyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeFromParent);
			
			destroyTimer.start();
			showTween.start();
		}
		
		function removeFromParent(e:TimerEvent):void
		{
			var hideTween:Tween = new Tween(bitMap, "alpha", Regular.easeOut, 1, 0, delay, true);
			hideTween.addEventListener(TweenEvent.MOTION_FINISH, kill);
		}
		
		function kill(e:TweenEvent)
		{
			this.removeChild(bitMap);
			isShowing = false;
		}
	}
}