package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	[SWF(frameRate="60", width="800", height="600", backgroundColor="0xFFFFFF")]
	public class Main extends Sprite
	{
		private var _starling:Starling;
		private var _window:Image;
		
		public function Main()
		{
			_starling = new Starling(Window, stage);	
			_starling.simulateMultitouch = true;
			_starling.start();
			
			
			
			
		}
		
		
		
//		private function onTouch(event:TouchEvent):void
//		{
//			var touch:Touch = event.getTouch(stage);
//			
//			if(touch)
//			{
//				//var localPos:Point = touch.getLocation(this);
//				//trace("Touched object at position : " + localPos);
//			}
//			
//		}
		
	}
}