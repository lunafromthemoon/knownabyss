﻿package  {
	
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundInstance;
	import treefortress.sound.SoundManager;
	
	public class SoundManager {
		
		var rootDirectory:String = "assets/sounds/";

		public function SoundManager() {
			SoundAS.loadSound(rootDirectory + "Placeholder.mp3", "Placeholder");
		}
		
		public function LoadSound(file:String, name:String)
		{
			SoundAS.loadSound(rootDirectory + file, name);
		}
		
		public function PlaySound(name:String)
		{
			SoundAS.play(name, 1, 0, 1, true, true, false);
		}
		
		public function PlayLoop(name:String)
		{
			SoundAS.play(name, 1, 0, -1, true, true, true);
		}
		
		public function FadeOut(name:String)
		{
			SoundAS.getSound(name).fadeTo(0);
		}
		
		public function FadeOutAll()
		{
			SoundAS.fadeMasterTo(0);
		}
		
		public function PauseAll()
		{
			SoundAS.pauseAll();
		}
		
		public function ResumeAll()
		{
			SoundAS.resumeAll();
		}
		
		public function Pause(name:String)
		{
			var sound:SoundInstance = SoundAS.getSound(name);
			if (!sound.isPaused)
			{
				sound.pause();
			}
		}
		
		public function Resume(name:String)
		{
			var sound:SoundInstance = SoundAS.getSound(name);
			if (sound.isPaused)
			{
				sound.resume();
			}
		}
	}
	
}