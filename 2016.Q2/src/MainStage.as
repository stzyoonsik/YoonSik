package
{
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainStage extends Sprite
	{
		private var _starling:Starling;
		private var _window:Window;
		private var _num:int = 0;
		
		
		public function MainStage()
		{
			//리무브 해야함
			
			addEventListener(Event.ADDED_TO_STAGE, onInit);
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
					var currentPos:Point = touch.getLocation(parent);
					
					_window = new Window();
					_window.x = currentPos.x;
					_window.y = currentPos.y;
					_window.name = String(_num++);
					
					
					addChild(_window);
					
					trace(_window.name + "윈도우 생성");
					
				
				}			
				
			}			
		
		}
	}
}