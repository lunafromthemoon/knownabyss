package {
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Cursor extends MovieClip {
		public var animation:Animation;
		public var draw:Boolean = false;
		
		public function Cursor()
		{
			
		}
		
		public function setAnimation(a:Animation)
		{
			animation = a;
		}
		
		public function setPosition(pos:Point)
		{
			x = pos.x;
			y = pos.y;
		}
		
		public function getPosition():Point
		{
			return new Point(x, y);
		}
	}
}