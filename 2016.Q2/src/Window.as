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
		
		/**
		 * 
		 * @param e
		 * 모든 이벤트들을 관장하는 메소드
		 */
		private function onAddedToStage(e:Event):void
		{
			_titleBar.addEventListener(TouchEvent.TOUCH, onDragTitleBar);
			_minimize.addEventListener(TouchEvent.TOUCH, onMinimize);
			_revert.addEventListener(TouchEvent.TOUCH, onRevert);
			_close.addEventListener(TouchEvent.TOUCH, onClose);
		}
		
		/**
		 * 
		 * @param e
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 미니마이즈 버튼을 클릭하면 content의 높이를 0으로 한다
		 */
		private function onMinimize(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_minimize, TouchPhase.ENDED);
			if(touch)
			{
				trace("최소화");
				_contents.height = 0;
			}
		}
		
		/**
		 * 
		 * @param e
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 리버트 버튼을 클릭하면 content의 높이를 256으로 한다
		 */
		private function onRevert(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_revert, TouchPhase.ENDED);
			if(touch)
			{
				trace("최대화");
				_contents.height = 256;
			}
		}
		
		/**
		 * 
		 * @param e
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 터치 이벤트가 발생하면 모든 이벤트 리스너를 제거하고 부모로부터 삭제된다
		 */
		private function onClose(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_close, TouchPhase.ENDED);
			if(touch)
			{
				trace("종료");
				
				_titleBar.removeEventListener(TouchEvent.TOUCH, onDragTitleBar);
				_minimize.removeEventListener(TouchEvent.TOUCH, onMinimize);
				_revert.removeEventListener(TouchEvent.TOUCH, onRevert);
				_close.removeEventListener(TouchEvent.TOUCH, onClose);
				
				removeEventListener(TouchEvent.TOUCH, onAddedToStage);
				
				removeFromParent();
				
			}
		}
		
		/**
		 * 
		 * @param e
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 터치 이벤트가 발생하면 드래그 앤 드롭을 통해 오브젝트들을 이동시켜주는 메소드
		 */
		private function onDragTitleBar(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_titleBar);

			
			touch = e.getTouch(_titleBar, TouchPhase.MOVED);
			if(touch)
			{
				var currentPos:Point = touch.getLocation(parent);
				var previousPos:Point = touch.getPreviousLocation(parent);
				var delta:Point = currentPos.subtract(previousPos);
				
				
				moveWindow(delta);
				
				
			}
		}
		
		
		
		/**
		 * 
		 * @param point 
		 * 현재 위치에서 point의 위치 까지 오브젝트들을 이동시키는 메소드 
		 * 
		 */
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