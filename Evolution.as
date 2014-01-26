package  {
	
	import flash.utils.Dictionary;
	
	public class Evolution {

		private var dependencies:Dictionary;
		private var maxLevel:int;
		public var currentLevel:int;
		public  var name:String;
		
		public var animations:Array;
		public var currentAnimation:Animation;
		
		public function Evolution(maxLevel:int,dependencies:Dictionary,charName:String) {
			this.maxLevel = maxLevel;
			this.dependencies = dependencies;
			this.currentLevel = 0;
		}
		
		public function toString():String{
			var str:String = "{";			
			for(var i:int = 1;i<maxLevel+1;i++){
				var deps:Dictionary = dependencies[i];
				if (deps!=null)
					str+=i+":"+ showDictionary(deps)+";";
			}
			str+="}";
			return str;
		}
		
		public function showDictionary(dict:Dictionary):String{
			if (dict == null)
				return "(no deps)";
			var str:String = "("	
			for (var key:* in dict) {
				str += "deps[" + key + "] = " + dict[key]+",";
			}
			return str+")";
		}
		
		public function evolve(currentState:Dictionary){			
			if(this.currentLevel<this.maxLevel){
				var evolve:Boolean = true;
				var levelDeps:Dictionary = this.dependencies[currentLevel];
				trace(showDictionary(levelDeps));
				for (var key:* in levelDeps) {
					if (levelDeps[key]>currentState[key]){
						evolve = false;
					}
				}				
				if (evolve) {
					this.currentLevel++;
					currentAnimation = animations[currentLevel - 1];
					//TODO evolution visual logic
				}
			}			
			
		}
		
		public function setAnimations(a:Array)
		{
			animations = a;
			currentAnimation = animations[0];
		}
	}
	
}
