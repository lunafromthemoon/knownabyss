package  {
	import flash.display.Loader;
	
	import flash.utils.Dictionary;
	import flash.display.BitmapData;
	import flash.events.Event;	
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class BitmapManager extends EventDispatcher{
		
		public static const TILES_LOADED:String = "TilesLoaded";
		
		private var loader:Loader = new Loader();
		
		private var toLoad:Array = new Array();
		private var loadingIndex:int = 0;
		private var files:Dictionary = new Dictionary();
		private var loaded:Dictionary = new Dictionary();
		private var allReady:Boolean = false;
		private var tilesXML:XML;
		private var fileName:String;
		
		public function BitmapManager(fileName:String) {
			this.fileName = fileName;
		}
		
		private function allowStart(event:Event){
			tilesXML = new XML(event.target.data);
			for(var i:int = 0;i<tilesXML.AnimationTileSet.length();i++){
				var animationTileSet:XML = tilesXML.AnimationTileSet[i];
				var animationName:String = animationTileSet.@Name;
				toLoad.push(animationName);				
				files[animationName] = animationTileSet.@FileName;
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadTileSet);			
			loader.load(new URLRequest(files[toLoad[loadingIndex]]));
		}
		
		public function loadAll(){			
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest(fileName));
			myLoader.addEventListener(Event.COMPLETE, allowStart);
		}
		
		private function loadTileSet(event:Event):void {
			var bm:BitmapData = Bitmap(LoaderInfo(event.target).content).bitmapData;
			loaded[toLoad[loadingIndex]] = bm;
			loadingIndex++;
			if(loadingIndex<toLoad.length)
				loader.load(new URLRequest(files[toLoad[loadingIndex]]));
			else 
				dispatchEvent(new Event(TILES_LOADED));
		}
		
		public function getTileSet(tileType:String):BitmapData{
			return loaded[tileType];
		}
		
		public function getAnimationsFromTileSet(tileSetName:String):Array{
			var bm:BitmapData = loaded[tileSetName];
			var xml:XML = tilesXML.AnimationTileSet.(@Name==tileSetName)[0];
			
			var frameW:int = int(xml.FrameWidth[0]);
			var frameH:int = int(xml.FrameHeight[0]);
			
			
			var animArray:Array = new Array();
			for(var i:int = 0;i<xml.Animation.length();i++){
				var anim:XML = xml.Animation[i];
				var nof:int = anim.NumberOfFrames[0];
				var animTileSet:BitmapData = new BitmapData(frameW*nof,frameH,true, 0x00FF0000);

				animTileSet.copyPixels(bm,new Rectangle(0,i*frameH,frameW*nof,frameH),new Point(0,0));
				
				var animDelay:Array = null;
				var delayString:String = anim.Delay.length()>0 ? anim.Delay[0] : null;
				if(delayString!=null)
					animDelay=delayString.split(",");
				animArray.push(new Animation(anim.@Name,animTileSet,frameW,frameH,nof,animDelay));
			}
			return animArray;
		}
		
		public static function flipBitmapData(bm:BitmapData, axis:String = "x"):BitmapData
		{
			 var flipped:BitmapData = new BitmapData(bm.width, bm.height, true, 0);
			 var matrix:Matrix;
			 if(axis == "x"){
				  matrix = new Matrix( -1, 0, 0, 1, bm.width, 0);
			 } else {
				  matrix = new Matrix( 1, 0, 0, -1, 0, bm.height);
			 }
			 flipped.draw(bm, matrix, null, null, null, true);
			 return flipped;
		}
		
		public static function getAlphaBitmap(w:int,h:int):BitmapData{
			var argb:uint = 0x000000;
		  	argb += (255<<24);
			return new BitmapData(w, h, true, argb);
		}

	}
	
}
