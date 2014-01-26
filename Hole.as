package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class Hole extends MovieClip
	{
		var evolutions:Vector.<Evolution> = new Vector.<Evolution>();
		var currentState:Dictionary = new Dictionary();
		var currentLevel:int = 0;
		var messageBox:MessageBox;
		
		public function Hole()
		{

		}
		
		public function addEvolution(c:Character)
		{
			evolutions.push(c.getEvol());
			GameScene.currentMove++;
			if (CharacterFactory.charNames.indexOf(c.getName()) == GameScene.currentMove) 
			{
				//right move
				
				//supersonido
				//mensajecursi
				dispatchEvent(new Event("LevelUp"));
				
				currentLevel++;				
				if (currentLevel == 6)
				{
					trace("winning");
					dispatchEvent(new Event("YouWin"));
				}
			}
			else
			{
				//wrong move
			}
			updateCurrentState();
			for (var i:int = 0; i < evolutions.length; i++)
			{				
				evolutions[i].evolve(currentState);
				//trace(evolutions[i].name+" "+evolutions[i].currentLevel);
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