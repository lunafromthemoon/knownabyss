package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Character extends MovieClip {
		
		public static var ANIM_STANDBY:String = "StandBy";
		
		private var charName:String;
		private var evolution:Evolution;
		private var clickMask:CharacterAMask;
		public var animations:Array;
		public var currentAnimation:Animation;
		//animations
		
		public function Character(charName:String, evolution:Evolution, pos:Point ) {
			this.charName = charName;
			this.evolution = evolution;
			x = pos.x;
			y = pos.y;
		}
		
		public function setMask(){
			clickMask = new CharacterAMask();
			clickMask.alpha = 0;
			this.addChild(clickMask);
			clickMask.addEventListener(MouseEvent.CLICK,clickOnChar);
		}
		
		public function clickOnChar(e:MouseEvent) {
			trace(charName);
		}
		
		public function setData() {
			
		}
		
		public function getName():String {
			return charName;
		}
		
		public function getEvol():Evolution{
			return evolution;
		}
		
		public function setAnimations(a:Array)
		{
			animations = a;		
			
			for (var i:int = 0; i < animations.length; i++)
			{
				if (animations[i].getName() == ANIM_STANDBY)
					currentAnimation = animations[i];
			}
		}
		
		public function getPosition():Point
		{
			return new Point(x, y);
		}
	}
	
}
