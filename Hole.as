package {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	public class Hole extends MovieClip
	{
		var evolutions:Vector.<Evolution> = new Vector.<Evolution>();
		var currentState:Dictionary = new Dictionary();
		
		public function Hole()
		{
			
		}
		
		public function addEvolution(c:Character)
		{
			evolutions.push(c.getEvol());
			updateCurrentState();
			for (var i:int = 0; i < evolutions.length; i++)
			{
				evolutions[i].evolve(currentState);
			}
		}
		
		public function updateCurrentState()
		{			
			for (var i:int = 0; i < evolutions.length; i++)
			{
				currentState[evolutions[i].name] = evolutions[i].currentLevel;
			}			
		}
	}
}