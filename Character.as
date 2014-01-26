package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Character extends MovieClip {
		
		public static var ANIM_STANDBY:String = "StandBy";
		
		private var charName:String;
		private var evolution:Evolution;
		public var clickMask:Sprite;
		public var animations:Array;
		public var currentAnimation:Animation;
		public var maskPos:Point;
		//animations
		
		public function Character(charName:String, evolution:Evolution, pos:Point, maskPos:Point ) {
			this.charName = charName;
			this.evolution = evolution;
			x = pos.x;
			y = pos.y;
			this.maskPos = maskPos;
		}
		
		public function setMask(){			
			clickMask = new Sprite();
			clickMask.graphics.beginFill(0xFFAAFF);
			//clickMask.graphics.drawCircle(maskPos.x, maskPos.y, 30);
			clickMask.graphics.drawEllipse(maskPos.x, maskPos.y, currentAnimation.animFrameW * 0.8, currentAnimation.animFrameH);
			clickMask.graphics.endFill();			
			clickMask.alpha = 0;
			this.addChild(clickMask);			
			clickMask.addEventListener(MouseEvent.CLICK, clickOnChar);
		}
		
		public function clickOnChar(e:MouseEvent) {						
			this.dispatchEvent(new Event("evolve"));
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
			
			setMask();
		}
		
		public function getPosition():Point
		{
			return new Point(x, y);
		}
	}
	
}
