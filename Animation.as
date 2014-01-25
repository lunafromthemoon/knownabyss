package  {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class Animation {

		private var tiles:BitmapData;
		
		private var animName:String;
		
		private var animCount:int = 0;
		private var animIndex:int = 0;
		
		private var animLastFrame:int;
		private var animDelay:Array;
		private var animFrameSize:int;

		public function Animation(animName:String,tiles:BitmapData,animFrameSize:int,animLastFrame:int,animDelay:Array=null) {
			this.tiles = tiles;
			this.animName = animName;
			this.animLastFrame = animLastFrame;
			this.animDelay = animDelay;
			this.animFrameSize = animFrameSize;
		}
		
		public function getName():String{
			return animName;
		}
		
		public function getTileSet():BitmapData{
			return tiles;
		}
		
		public function getNextFrame():BitmapData{
			var frame:BitmapData = new BitmapData(animFrameSize,animFrameSize,true, 0x00FF0000);
			var rect:Rectangle = new Rectangle(animIndex*animFrameSize,0,animFrameSize,animFrameSize);
			frame.copyPixels(tiles,rect,new Point(0,0));
			
			animCount++;
			if(animDelay==null || animCount==animDelay[animIndex]){
				
				animCount=0;
				animIndex++;
			}
			if(animIndex==animLastFrame)
				animIndex=0;
			
			return frame;
		}

	}
	
}
