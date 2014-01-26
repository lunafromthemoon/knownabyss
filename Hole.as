package {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	public class Hole extends MovieClip
	{
		var evolutions:Vector.<Evolution> = new Vector.<Evolution>();
		var foo:Array;
		var currentState:Dictionary = new Dictionary();
		
		public function Hole()
		{
			foo = CharacterFactory.createCharacters();
		}
		
		public function addEvolution(c:Character)
		{
			evolutions.push(c.getEvol());
			for (var i:int = 0; i < evolutions.length; i++)
			{
				evolutions[i].evolve(currentState);
			}
		}
		
		public function getCurrentState():Dictionary
		{
			var currentState = new Dictionary();
			
			for (var i:int = 0; i < evolutions.length; i++)
			{
				currentState[evolutions[i].name] = evolutions[i].currentLevel;
			}
		}
	}
}