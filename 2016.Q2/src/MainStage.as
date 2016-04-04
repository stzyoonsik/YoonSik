package
{
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainStage extends Sprite
	{
		private var _starling:Starling;
		private var _vecWindow:Vector.<Window> = new Vector.<Window>;
		
		public function MainStage()
		{
			//리무브 해야함
			
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			
			//var window:Window = new Window();
			//addChild(window);
		}
		
		private function onInit():void
		{
			stage.addEventListener(TouchEvent.TOUCH, onAddWindow);
		}
		
		private function onAddWindow(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.ENDED);
			
			
			if(touch)
			{
				if(touch.target == stage)
				{
					trace("윈도우 생성");
					var window:Window = new Window();
					var currentPos:Point = touch.getLocation(parent);
					
					window.x = currentPos.x;
					window.y = currentPos.y;
					
					
					addChild(window);
					_vecWindow.push(window);
				}
				
				
				
			}
		
		}
	}
}