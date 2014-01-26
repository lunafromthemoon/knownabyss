package {
	import flash.display.MovieClip;
	
	public class Hole extends MovieClip
	{
		var evolutions:Vector.<Evolution> = new Vector.<Evolution>();
		var foo:Array;
		public function Hole()
		{
			foo = CharacterFactory.createCharacters();
		}
		
		public function addEvolution(c:Character)
		{
			evolutions.push(e);
			for (var i:int = 0; i < evolutions.length; i++)
			{
				evolutions[i].evolve(foo[c.getName()][c.getEvol()]);
			}
		}
	}
}