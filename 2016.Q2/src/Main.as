package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	[SWF(frameRate="60", width="800", height="600", backgroundColor="0xFFFFFF")]
	public class Main extends Sprite
	{
		private var _starling:Starling;
		public function Main()
		{
			_starling = new Starling(Game, stage);			
			_starling.start();
		}
	}
}