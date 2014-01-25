package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Character extends MovieClip {
		
		private var charName:String;
		private var evolution:Evolution;
		private var clickMask:CharacterAMask;
		//animations
		
		public function Character(){
			
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
		
		public function setData(charName:String,evolution:Evolution) {
			this.charName = charName;
			this.evolution = evolution;
		}
		
		public function getName():String {
			return charName;
		}
		
		public function getEvol():Evolution{
			return evolution;
		}

	}
	
}
