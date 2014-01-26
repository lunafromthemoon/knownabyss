package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter; 
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.display.Shape;
	
	public class GameScene extends MovieClip 
	{
		
		private var bitmapManager:BitmapManager = new BitmapManager("Animations.xml");
		private var backgroundDisplay:Bitmap;
		private var iteration:int = 0;
		var characters:Array = CharacterFactory.createCharacters();
		var charactersDisplay:Array = new Array();
		public var messages:Array = new Array();
		public var messageBox:MessageBox;
		private var cursorDisplay:Bitmap = null;
		private var hole:Hole = new Hole();
		private var cursor:Cursor = new Cursor();
		public static var currentMove:int = -1;

		public var soundManager:SoundManager;
		public var correctMoves:int = 0;

		var enlargeX:Tween;
		var enlargeY:Tween;
		var upAndDown:Tween;
		
		private var blackHoleDisplay:Bitmap;
		private var blackHoleCloudsDisplay:Bitmap;

		
		public function GameScene() {			
			bitmapManager.addEventListener(BitmapManager.TILES_LOADED,startGame);
			bitmapManager.loadAll();
			hole.addEventListener("YouWin", onYouWin);
		}
		
		public function onYouWin(e:Event)
		{			
			var asd:WinScene = new WinScene();
			addChild(asd);
		}
		
		public function clickOnChar(e:Event) {
			if(blackHoleDisplay!=null){
				this.removeChild(blackHoleDisplay);
				this.removeChild(blackHoleCloudsDisplay);
				blackHoleDisplay=null;
				
			}
			//trace(e.target.getName());
			hole.addEvolution(e.target as Character);
			e.target.clickMask.removeEventListener(MouseEvent.MOUSE_OVER, onCharMouseOver);
			e.target.clickMask.removeEventListener(MouseEvent.MOUSE_OUT, onCharMouseOut);
			e.target.removeChild(cursor);
			cursor.draw = false;
			e.target.removeEventListener("evolve",clickOnChar);
		}
		
		private function startGame(event:Event):void{
			//load bitmaps			
			characters[0].setAnimations( bitmapManager.getAnimationsFromTileSet("Faith"));			
			characters[1].setAnimations( bitmapManager.getAnimationsFromTileSet("Science"));
			characters[2].setAnimations( bitmapManager.getAnimationsFromTileSet("Love"));
			characters[3].setAnimations( bitmapManager.getAnimationsFromTileSet("Wisdom"));
			characters[4].setAnimations( bitmapManager.getAnimationsFromTileSet("Art"));
			characters[5].setAnimations( bitmapManager.getAnimationsFromTileSet("Innocence"));
			characters[0].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionA"),new Point(275,175));
			characters[1].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionB"),new Point(275,175));
			characters[2].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionC"),new Point(275,175));
			characters[3].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionD"),new Point(275,175));
			characters[4].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionE"),new Point(275,175));
			characters[5].getEvol().setAnimations(bitmapManager.getAnimationsFromTileSet("EvolutionF"),new Point(250,150));
			
			backgroundDisplay = new Bitmap(bitmapManager.getTileSet("Background"));
			
			//Load Messages
			for (var i:int = 0; i < 6; i++)
			{
				messages[i] = new Bitmap(bitmapManager.getTileSet("MessageBox" + i));
				messages[i].x = (800 - messages[i].width) / 2;
				messages[i].y = 20;
			}
			messageBox = new MessageBox(messages);
			
			
			backgroundDisplay.x = backgroundDisplay.y = 0;
			this.addChild(backgroundDisplay);
			this.addChild(messageBox);
			
			//Configure SoundManager
			soundManager = new SoundManager();
			
			for (var i:int = 1; i < 7; i++)
			{
				soundManager.PlayLoop("Tune" + i);
			}
			soundManager.FadeIn("Tune1");
			
			hole.addEventListener("LevelUp", LevelUp);
			
			for (var i:int = 0; i < characters.length; i++)
			{
				characters[i].clickMask.addEventListener(MouseEvent.MOUSE_OVER, onCharMouseOver);
				characters[i].clickMask.addEventListener(MouseEvent.MOUSE_OUT, onCharMouseOut);
			}			
			var char = characters[0];
			characters[0] = characters[3];
			characters[3] = char;
			for(var i:int = 0;i<characters.length;i++){				
				var tile:BitmapData = characters[i].currentAnimation.getNextFrame();
				var bitmapChar:Bitmap = new Bitmap(tile);
				bitmapChar.x = characters[i].x;
				bitmapChar.y = characters[i].y;
				this.addChild(bitmapChar);
				this.addChild(characters[i]);				
				characters[i].addEventListener("evolve",clickOnChar);
			}
			setBlackHole();
			cursor.setAnimation(bitmapManager.getAnimationsFromTileSet("Cursor")[0]);
			addEventListener(Event.ENTER_FRAME, gameLoop);
			
			//dispatchEvent(new Event("YouWin"));
		}
		
		public function LevelUp(me:Event)
		{
			correctMoves++;
			messageBox.showMessage(correctMoves, 5);
			if(correctMoves<6)
				soundManager.FadeIn("Tune" + (correctMoves + 1));
		}

		public function setBlackHole(){
			blackHoleDisplay = new Bitmap(bitmapManager.getTileSet("BlackHole"));
			blackHoleCloudsDisplay = new Bitmap(bitmapManager.getTileSet("BlackHoleClouds"));
			this.addChild(blackHoleDisplay);
			this.addChild(blackHoleCloudsDisplay);
			blackHoleCloudsDisplay.x=310;
			upAndDown = new Tween(blackHoleCloudsDisplay, "y", Regular.easeOut, 290, 285, 2, true);
			enlargeX = new Tween(blackHoleDisplay, "scaleX", Regular.easeOut, 1, 1.03, 1, true);
			enlargeY = new Tween(blackHoleDisplay, "scaleY", Regular.easeOut, 1, 1.1, 1, true);
			enlargeX.addEventListener(TweenEvent.MOTION_FINISH,rewind);
			upAndDown.addEventListener(TweenEvent.MOTION_FINISH,rewindClouds);
			enlargeX.start();
			enlargeY.start();
			upAndDown.start();			
		}
		
		public function rewind(me:TweenEvent){
			enlargeX.yoyo();
			enlargeY.yoyo();
		}
		public function rewindClouds(me:TweenEvent){
			upAndDown.yoyo();
		}
		
		public function onCharMouseOver(me:MouseEvent)
		{
			var char:Character = me.target.parent as Character;
			char.addChild(cursor);
			cursor.draw = true;
			cursor.setPosition(new Point(char.x + char.currentAnimation.animFrameW/2 - cursor.animation.animFrameW/2, char.y - cursor.animation.animFrameH * 1.5));
		}
		
		public function onCharMouseOut(me:MouseEvent)
		{
			cursor.setPosition(new Point( -50, -50));
			cursor.draw = false;
			(me.target.parent as Character).removeChild(cursor);
			if (cursorDisplay!=null && this.cursorDisplay.parent){
				this.cursorDisplay.parent.removeChild(cursorDisplay);
			}		
		}
		
		public function gameLoop(e:Event) {
			drawCharacters();
		}
		
		private function drawCharacters():void {
			iteration++;
			for(var i:int = 0;i<characters.length;i++){
				if (this.charactersDisplay[i]!=null && this.charactersDisplay[i].parent){
					this.charactersDisplay[i].parent.removeChild(charactersDisplay[i]);
				}
				var anim:Animation = characters[i].getEvol().getCurrentAnimation();
				if (anim!=null) {
					var tile:BitmapData = anim.getNextFrame();					
					this.charactersDisplay[i] = new Bitmap(tile);
					this.charactersDisplay[i].x = characters[i].getEvol().position.x;
					this.charactersDisplay[i].y = characters[i].getEvol().position.y;
					this.addChild(charactersDisplay[i]);
				}				
			}
			if (blackHoleDisplay!=null){
				blackHoleDisplay.x = stage.width/2 - blackHoleDisplay.width/2;
				blackHoleDisplay.y = stage.height/2 - blackHoleDisplay.height/2;
			}
			if (cursorDisplay!=null && this.cursorDisplay.parent){
				this.cursorDisplay.parent.removeChild(cursorDisplay);			
			}
			if (cursor.draw) {
				var tileCursor = cursor.animation.getNextFrame()
				cursorDisplay = new Bitmap(tileCursor);
				cursorDisplay.x = cursor.getPosition().x;
				cursorDisplay.y = cursor.getPosition().y;
				this.addChild(cursorDisplay);
			}			
		}
	}
}