package  {
	
	import flash.utils.Dictionary;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class Evolution {

		private var dependencies:Dictionary;
		private var maxLevel:int;
		public var currentLevel:int;
		public  var name:String;
		public var position:Point;
		public var animations:Array;
		
		public function Evolution(maxLevel:int,dependencies:Dictionary,charName:String) {
			this.maxLevel = maxLevel;
			this.dependencies = dependencies;
			this.currentLevel = 0;
			this.name = charName;
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
				for (var key:* in levelDeps) {
					if (levelDeps[key]>currentState[key]){
						evolve = false;
					}
				}				
				if (evolve) {
					this.currentLevel++;					
				}
			}			
			
		}
		
		public function setAnimations(a:Array,pos:Point)
		{
			position = pos;
			animations = a;
		}
		
		public function getCurrentAnimation():Animation{
			if (currentLevel==0)
				return null;
			return animations[currentLevel-1];
		}
	}
	
}
