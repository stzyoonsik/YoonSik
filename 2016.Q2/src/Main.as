package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	//import starling.display.Sprite;

	[SWF(frameRate="60", width="800", height="600", backgroundColor="0xFFFFFF")]
	public class Main extends Sprite
	{
		
		[Embed(source = "background.png")]
		private static const Background:Class;
		
		//private var _background:Image = new Image(Texture.fromEmbeddedAsset(Background));
		
		private var _starling:Starling;
		//private var _window:Image;
		
		
		public function Main()
		{
			_starling = new Starling(Window, stage);	
			_starling.simulateMultitouch = true;
			_starling.start();
			
			//this.addEventListener(TouchEvent.TOUCH, onMakeWindow);
			
			
		}
		
		private function onMakeWindow(e:TouchEvent):void
		{
//			var touch:Touch = e.getTouch(this.);
//			if(touch.phase == TouchPhase.ENDED)
//			{
//				_starling = new Starling(Window, stage);	
//				_starling.simulateMultitouch = true;
//				_starling.start();
//			}
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