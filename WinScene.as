package {
	import fl.transitions.TweenEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	class WinScene extends MovieClip
	{
		var positions:Array = new Array(
			new Point(200,10),
			new Point(150,230),
			new Point(450,550),
			new Point(120,487),
			new Point(220,92),
			new Point(301,3),
			new Point(10,517),
			new Point(210,400),
			new Point(0, 300),
			new Point(200, 300)
		);
		
		var texts:Array = new Array(
			"J. E. Luna ~ Programming & Design",
			"Francisco Huidobro ~ Design & Production",
			"Matías Montenegro ~ 2D Artist",
			"Luciano Pites ~ Programming & Design",
			"Alexander \"NTOPEBN4\" Iartsev ~ Programming & Design",
			"Fernando Sarmiento ~ Design & Production",
			"Pablo Barberán ~ 2D Artist",
			"Mario Mentasti ~ Writing",
			"Alejandro Tiscornia ~ Music & SFX",
			"Joaquín Reymundo ~ 2D Artist",
			"Thank you very much for playing"
		);
		
		var label:TextMessageBox;
		
		var delayBetweenTexts:int = 3;
		var index:int = 0;
		
		public function WinScene()
		{
			var fade = new Shape();
			fade.graphics.beginFill(0x000000, 1);
			fade.graphics.drawRect(0, 0, 800, 600);
			fade.graphics.endFill();
			addChild(fade);
			
			var fadeInTween = new Tween(fade, "alpha", None.easeOut, 0, 0.85, 2, true);
			fadeInTween.addEventListener(TweenEvent.MOTION_FINISH, showTeam);
			fadeInTween.start();
		}
		
		public function showTeam(te:TweenEvent)
		{
			var timer:Timer = new Timer(5000, texts.length);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, showNextTeamMember);
		}
		
		public function showNextTeamMember(te:TimerEvent)
		{
			trace(index);
			label = new TextMessageBox(positions[index].x, positions[index].y, texts[index], 2);
			label.showText();
			addChild(label);
			index++;
		}
	}
}