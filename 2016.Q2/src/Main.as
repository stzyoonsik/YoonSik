package
{
	import flash.display.Sprite;	
	import starling.core.Starling;

	[SWF(frameRate="60", width="800", height="600", backgroundColor="0xFFFFFF")]
	public class Main extends Sprite
	{		
		public function Main()
		{
			var _starling:Starling;
			_starling = new Starling(MainStage, stage);	
			_starling.start();
			
		}
	}
}