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
		import flash.text.TextFieldAutoSize;
        import flash.utils.Timer;
        import flash.events.TimerEvent;
        import flash.filters.GlowFilter;
        
        public class TextMessageBox extends MovieClip
        {
                var textField:TextField;
                var pos:Point;
                
                var destroyDelay:int;
                var delay:int = 2;
                
                public function TextMessageBox(x:int, y:int, message:String, duration:int)
                {
                        pos = new Point(x, y);
                        
                        var textFilter = new GlowFilter(0x000000,1,2,2,2,1)
                        
                        textField = new TextField();
                        
                        textField.alpha = 0;
                        textField.textColor = 0xffffff;
                        
                        textField.text = message;
                        textField.x = pos.x;
                        textField.y = pos.y;
                        destroyDelay = duration;
                        
						textField.scaleX = 2;
						textField.scaleY = 2;
						textField.autoSize = TextFieldAutoSize.LEFT;
						
                        textField.filters = [textFilter];
                        
                        addChild(textField);
                }
                
                public function showText():void
                {
                        var showTween:Tween = new Tween(textField, "alpha", Regular.easeOut, 0, 1, 3, true);
                        var destroyTimer:Timer = new Timer(1000,delay + destroyDelay);
                        destroyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeFromParent);
                        
                        destroyTimer.start();
                        showTween.start();
                }
                
                function removeFromParent(e:TimerEvent):void
                {
                        var hideTween:Tween = new Tween(textField, "alpha", Regular.easeOut, 1, 0, 2, true);
                        hideTween.addEventListener(TweenEvent.MOTION_FINISH, kill);
                }
                
                function kill(e:TweenEvent)
                {
                        parent.removeChild(this);
                }
        }
}