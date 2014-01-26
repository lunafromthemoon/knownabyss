package  {
	
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundInstance;
	import treefortress.sound.SoundManager;
	
	public class SoundManager {
		
		var rootDirectory:String = "assets/sounds/";

		public function SoundManager() {
			SoundAS.loadSound(rootDirectory + "Known Abyss-1.mp3", "Tune1");
			SoundAS.loadSound(rootDirectory + "Known Abyss-2.mp3", "Tune2");
			SoundAS.loadSound(rootDirectory + "Known Abyss-3.mp3", "Tune3");
			SoundAS.loadSound(rootDirectory + "Known Abyss-4.mp3", "Tune4");
			SoundAS.loadSound(rootDirectory + "Known Abyss-5.mp3", "Tune5");
			SoundAS.loadSound(rootDirectory + "Known Abyss-6.mp3", "Tune6");
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
			SoundAS.play(name, 0, 0, -1, true, true, true);
		}
		
		public function FadeOut(name:String)
		{
			SoundAS.getSound(name).fadeTo(0);
		}
		
		public function FadeIn(name:String)
		{
			SoundAS.getSound(name).fadeTo(1);
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
