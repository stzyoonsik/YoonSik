package
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class Window extends Sprite
	{
		[Embed(source = "contents.png")]
		private static const Contents:Class;
		
		[Embed(source = "titleBar.png")]
		private static const TitleBar:Class;
		
		[Embed(source = "minimize.png")]
		private static const Minimize:Class;
		
		[Embed(source = "revert.png")]
		private static const Revert:Class;
		
		[Embed(source = "close.png")]
		private static const Close:Class;
		
		private var _contents:Image = new Image(Texture.fromEmbeddedAsset(Contents));
		private var _titleBar:Image = new Image(Texture.fromEmbeddedAsset(TitleBar));
		private var _minimize:Image = new Image(Texture.fromEmbeddedAsset(Minimize));
		private var _revert:Image = new Image(Texture.fromEmbeddedAsset(Revert));
		private var _close:Image = new Image(Texture.fromEmbeddedAsset(Close));
		
		
		public function Window()
		{
			//var bitmap:Bitmap = new Contents();
			//var texture:Texture = Texture.fromBitmap(bitmap)
			
			this.addEventListener(TouchEvent.TOUCH, onAddedToStage);
			
			var pos:Point = new Point(50,0);
			initPosition(pos);
			addChild(_titleBar);
			addChild(_contents);
			addChild(_minimize);
			addChild(_revert);
			addChild(_close);
			
		}
		
		/**
		 * 
		 * @param point 해당 좌표를 기준으로 오브젝트를 생성함
		 * 입력받은 좌표를 기준으로 5개의 오브젝트의 생성 위치를 초기화하는 메소드
		 */
		public function initPosition(point:Point):void
		{
			_titleBar.x = point.x;
			_titleBar.y = point.y;
			
			_contents.x = point.x;
			_contents.y = point.y + 32;
			
			_minimize.x = point.x + 418;
			_minimize.y = point.y;
			
			_revert.x = point.x + 450;
			_revert.y = point.y;
			
			_close.x = point.x + 480;
			_close.y = point.y;
		}
		
		private function onAddedToStage(e:Event):void
		{
			_titleBar.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			
		}
		
		private function onTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_titleBar);
//			if(touch)
//			{
//				switch(touch.phase)
//				{
//					case TouchPhase.BEGAN : _titleBar.setv
//				}
//			}
			
			touch = e.getTouch(_titleBar, TouchPhase.MOVED);
			if(touch)
			{
				var currentPos:Point = touch.getLocation(parent);
				var previousPos:Point = touch.getPreviousLocation(parent);
				var delta:Point = currentPos.subtract(previousPos);
				
				//_titleBar.x += delta.x;
				//_titleBar.y += delta.y;
				
				moveWindow(delta);
				
				
			}
		}
		
		private function moveWindow(point:Point):void
		{
			_titleBar.x += point.x;
			_titleBar.y += point.y;
			
			_contents.x += point.x;
			_contents.y += point.y;
			
			_minimize.x += point.x;
			_minimize.y += point.y;
			
			_revert.x += point.x;
			_revert.y += point.y;
			
			_close.x += point.x;
			_close.y += point.y;
			
			
		}
	}
}