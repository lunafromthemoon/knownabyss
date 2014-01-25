package  {
	
	import flash.display.MovieClip;
	
	
	public class Character extends MovieClip {
		
		private var charName:String;
		private var evolution:Evolution;
		//animations
		
		public function Character(){
			
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
