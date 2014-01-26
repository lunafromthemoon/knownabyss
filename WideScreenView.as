package  {
			import flash.display.Shape;
			import fl.transitions.Tween;
			import fl.transitions.easing.*;
			import fl.transitions.TweenEvent;
			import flash.display.MovieClip;
			
	public class WideScreenView  extends MovieClip{
			public var UpperScreen:Shape;
			public var LowerScreen:Shape;
			private var upperTween:Tween;
			private var lowerTween:Tween;
			
		public function WideScreenView() {
			UpperScreen = new Shape();
			UpperScreen.graphics.beginFill(0x000000, 1);
			UpperScreen.graphics.drawRect(0, -600, 800, 600);
			UpperScreen.graphics.endFill();
			
			LowerScreen = new Shape();
			LowerScreen.graphics.beginFill(0x000000, 1);
			LowerScreen.graphics.drawRect(0, 600, 800, 600);
			LowerScreen.graphics.endFill();
		}
		
		public function FocusScreen(posY:int, bufferY:int)
		{
			parent.addChild(UpperScreen);
			parent.addChild(LowerScreen);
			
			lowerTween = new Tween(LowerScreen, "y", Strong.easeOut, LowerScreen.y, posY + bufferY - LowerScreen.height, 60, false);
			upperTween = new Tween(UpperScreen, "y", Strong.easeOut, UpperScreen.y, posY - bufferY, 60, false);
			lowerTween.start();
			upperTween.start();
			lowerTween.addEventListener(TweenEvent.MOTION_FINISH, onLowerFinish);
			function onLowerFinish(e:TweenEvent):void
			{
				trace("LowerScreen: " + lowerTween.obj.y);
			}
			upperTween.addEventListener(TweenEvent.MOTION_FINISH, onUpperFinish);
			function onUpperFinish(e:TweenEvent):void
			{
				trace("UpperScreen: " + upperTween.obj.y);
			}
			
		}

	}
	
}
