package  {
	
	import flash.utils.Dictionary;
	
	public class CharacterFactory {

		private static var charNames:Array = new Array("A","B","C","D","E","F");

		public function CharacterFactory() {
			
		}
		
		public static function createCharacters():Array{
			var characters:Array = new Array();
			//A
			var aDeps:Dictionary = new Dictionary();			
			aDeps[1] = aDeps[2] = aDeps[4] = aDeps[5] = null;
			aDeps[3] = new Dictionary();
			aDeps[3]["B"]=1;
			aDeps[6] = new Dictionary();
			aDeps[6]["B"]=4;aDeps[6]["C"]=3;aDeps[6]["D"]=2;aDeps[6]["E"]=1;aDeps[6]["F"]=0;
			var aEvol:Evolution = new Evolution(6,aDeps,characters);
			var aChar:CharacterA = new CharacterA();
			aChar.setData("A",aEvol);
			//var aChar:Character = new Character("A",aEvol);
			characters.push(aChar);
			//trace("A evol: "+aEvol.toString());
			//B
			var bDeps:Dictionary = new Dictionary();			
			bDeps[1] = bDeps[3] = null;
			bDeps[2] = new Dictionary();
			bDeps[2]["A"]=2;
			bDeps[4] = new Dictionary();
			bDeps[4]["C"]=2;
			bDeps[5] = new Dictionary();
			bDeps[5]["A"]=5;bDeps[5]["C"]=3;bDeps[5]["D"]=2;bDeps[5]["E"]=1;bDeps[5]["F"]=0;
			var bEvol:Evolution = new Evolution(5,bDeps,characters);
			var bChar:Character = new CharacterB();
			bChar.setData("B",bEvol);
			characters.push(bChar);
			//trace("B evol: "+bEvol.toString());
			//C
			var cDeps:Dictionary = new Dictionary();			
			cDeps[1] = cDeps[2] = cDeps[3] = null;			
			cDeps[4] = new Dictionary();
			cDeps[4]["A"]=5;cDeps[4]["B"]=4;cDeps[4]["D"]=2;cDeps[4]["E"]=1;cDeps[4]["F"]=0;
			var cEvol:Evolution = new Evolution(4,cDeps,characters);
			//var cChar:Character = new Character("C",cEvol);
			//characters.push(cChar);
			//trace("C evol: "+cEvol.toString());
			//D
			var dDeps:Dictionary = new Dictionary();			
			dDeps[1] = new Dictionary();
			dDeps[1]["C"]=1;
			dDeps[2] = new Dictionary();
			dDeps[2]["B"]=3;
			dDeps[3] = new Dictionary();
			dDeps[3]["A"]=5;dDeps[3]["B"]=4;dDeps[3]["C"]=3;dDeps[3]["E"]=1;dDeps[3]["F"]=0;
			var dEvol:Evolution = new Evolution(3,dDeps,characters);
			//var dChar:Character = new Character("D",dEvol);
			//characters.push(dChar);
			//trace("D evol: "+dEvol.toString());
			//E
			var eDeps:Dictionary = new Dictionary();			
			eDeps[1] = null;
			eDeps[2] = new Dictionary();
			eDeps[2]["A"]=5;eDeps[2]["B"]=4;eDeps[2]["C"]=3;eDeps[2]["D"]=2;eDeps[2]["F"]=0;
			var eEvol:Evolution = new Evolution(2,eDeps,characters);
			//var eChar:Character = new Character("E",eEvol);
			//characters.push(eChar);
			//trace("E evol: "+eEvol.toString());
			//F
			var fDeps:Dictionary = new Dictionary();
			fDeps[1] = new Dictionary();
			fDeps[1]["A"]=5;fDeps[1]["B"]=4;fDeps[1]["C"]=3;fDeps[1]["D"]=2;fDeps[1]["E"]=1;
			var fEvol:Evolution = new Evolution(1,fDeps,characters);
			//var fChar:Character = new Character("F",eEvol);
			//characters.push(fChar);
			//trace("F evol: "+fEvol.toString());
			return characters;
		}

	}
	
}
