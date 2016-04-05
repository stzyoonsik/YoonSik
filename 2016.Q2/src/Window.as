package
{
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Window extends Sprite
	{
		[Embed(source = "../images/contents.png")]
		private static const Contents:Class;
		
		[Embed(source = "../images/titleBar.png")]
		private static const TitleBar:Class;
		
		[Embed(source = "../images/minimize.png")]
		private static const Minimize:Class;
		
		[Embed(source = "../images/revert.png")]
		private static const Revert:Class;
		
		[Embed(source = "../images/close.png")]
		private static const Close:Class;
		
		[Embed(source = "../images/border.png")]
		private static const Border:Class;
		
		[Embed(source = "TextureAtlas.xml", mimeType="application/octet-stream")]
		private static const AtlasXml:Class;
		
		[Embed(source = "../images/flight_animation.png")]
		private static const AtlasTexture:Class;
		
		private var _contents:Image = new Image(Texture.fromEmbeddedAsset(Contents));
		private var _titleBar:Image = new Image(Texture.fromEmbeddedAsset(TitleBar));
		private var _minimize:Image = new Image(Texture.fromEmbeddedAsset(Minimize));
		private var _revert:Image = new Image(Texture.fromEmbeddedAsset(Revert));
		private var _close:Image = new Image(Texture.fromEmbeddedAsset(Close));
		private var _border:Image = new Image(Texture.fromEmbeddedAsset(Border));
		
		private var _texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		private var _xml:XML = XML(new AtlasXml());
		private var _atlas:TextureAtlas = new TextureAtlas(_texture, _xml);
		
		private var _movie:MovieClip = new MovieClip(_atlas.getTextures("flight_"), 4);
		
		
			
		private var _textField:TextField = new TextField(70,30);
		
		private var _spr:Sprite = new Sprite();
		
		private var _childWindow:Window;
		private var _vecChild:Vector.<Window> = new Vector.<Window>;
		private var _num:int = 0;
		
		public function Window()
		{			
			
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
						
			initPosition();
			
			_textField.autoSize = "left";
			_textField.scaleX = 1.2;
			_textField.scaleY = 1.2;
			
			_border.alpha = 0;
			addChild(_border);
			
			_spr.addChild(_titleBar);
			_spr.addChild(_textField);
			
			addChild(_spr);
			addChild(_contents);
			addChild(_minimize);
			addChild(_revert);
			addChild(_close);
			
			//this.pivotX = this.width / 2;
			//this.pivotY = this.height / 2;
			
			_movie.play();			
			Starling.juggler.add(_movie);
			addChild(_movie);
			
		}	
		
		

		/**
		 * 
		 * 
		 * 입력받은 좌표를 기준으로 5개의 오브젝트의 생성 위치를 초기화하는 메소드
		 */
		private function initPosition():void
		{
			
			_titleBar.x = this.x;
			_titleBar.y = this.y;
			
			_contents.x = this.x;
			_contents.y = this.y + 32;
			
			_minimize.x = this.x + 418;
			_minimize.y = this.y;
			
			_revert.x = this.x + 450;
			_revert.y = this.y;
			
			_close.x = this.x + 480;
			_close.y = this.y;
			
			_textField.x = this.x;
			_textField.y = this.y;
			
			_border.x = this.x - 5;
			_border.y = this.y - 5;
			
			_movie.x = this.x;
			_movie.y = this.y + 100;
		}
		
		/**
		 * 
		 * @param e 이벤트
		 * 모든 이벤트들을 관장하는 메소드
		 */
		private function onAddedEvents(e:Event):void
		{
			_spr.addEventListener(TouchEvent.TOUCH, onDragTitleBar);
			_minimize.addEventListener(TouchEvent.TOUCH, onMinimize);
			_revert.addEventListener(TouchEvent.TOUCH, onRevert);
			_close.addEventListener(TouchEvent.TOUCH, onClose);
			_contents.addEventListener(TouchEvent.TOUCH, onMakeChild);
			
			this.addEventListener(TouchEvent.TOUCH, onChangeScale);
			
			_textField.text = this.name;
			
		}
		
		/**
		 * 
		 * @param e 터치이벤트
		 * 모든 자식 윈도우를 생성하는 콜백 메소드
		 */
		private function onMakeChild(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_contents, TouchPhase.ENDED);
			if(touch)
			{								
				var currentPos:Point = touch.getLocation(this);				
				_childWindow = new Window()
				
				_childWindow.x = currentPos.x;
				_childWindow.y = currentPos.y;
				_childWindow.name = this.name + "-" + String(_num++); 
				
				addChild(_childWindow);
				_vecChild.push(_childWindow);
				
				trace(_childWindow.name + "자식 생성");
			}
		}
		
		/**
		 * 
		 * @param e 터치이벤트
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 미니마이즈 버튼을 클릭하면 content의 visible를 false로 한다
		 */
		private function onMinimize(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_minimize, TouchPhase.ENDED);
			if(touch)
			{
				trace(this.name + "최소화");
				_contents.visible = false;
				
				//_childWindow.visible = false;
				for(var i:int = 0; i<_vecChild.length; ++i)
				{
					_vecChild[i].visible = false;
				}
				
			}
		}
		
		/**
		 * 
		 * @param e 터치이벤트
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 리버트 버튼을 클릭하면 content의 visible을 true로 한다
		 */
		private function onRevert(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_revert, TouchPhase.ENDED);
			if(touch)
			{
				trace(this.name + "최대화");
				_contents.visible = true;
				
				for(var i:int = 0; i<_vecChild.length; ++i)
				{
					_vecChild[i].visible = true;
				}
				
			}
		}
		
		/**
		 * 
		 * @param e 터치이벤트
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 터치 이벤트가 발생하면 모든 이벤트 리스너를 제거하고 부모로부터 삭제된다
		 */
		private function onClose(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_close, TouchPhase.ENDED);
			if(touch)
			{
				trace(this.name + "종료");
				_num--;
				_vecChild.pop();
				
											
				this.removeEventListeners(TouchEvent.TOUCH);
				
				this.removeEventListener(TouchEvent.TOUCH, onAddedEvents);
				
				this.removeFromParent();
				
			}
		}
		
		/**
		 * 
		 * @param e 터치이벤트
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 터치 이벤트가 발생하면 드래그 앤 드롭을 통해 오브젝트들을 이동시켜주는 메소드
		 */
		private function onDragTitleBar(e:TouchEvent):void
		{
			var touch:Touch;			
			
			touch = e.getTouch(_spr, TouchPhase.MOVED);
			
			if(touch)
			{
				var currentPos:Point = touch.getLocation(parent);
				var previousPos:Point = touch.getPreviousLocation(parent);
				var delta:Point = currentPos.subtract(previousPos);
				
				this.x += delta.x;
				this.y += delta.y;
				
				//드래그 하는 동안 알파값 조정
				this.alpha = 0.5;
			}
			
			else
			{
				this.alpha = 1;
			}
			
			
			//그냥 클릭했을 경우, 현재 선택된 윈도우가 가장 가까이 보이게 함
			touch = e.getTouch(_spr, TouchPhase.ENDED);
			if(touch)
			{
				this.parent.setChildIndex(this, this.parent.numChildren);
			}
			
			
		}
		
		/**
		 * 
		 * @param e 터치이벤트
		 * 보더를 드래그앤 드롭 할 시 현재 윈도우의 크기를 바꿔주는 콜백 메소드
		 */
		private function onChangeScale(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_border, TouchPhase.MOVED);
			
			if(touch)
			{
				var currentPos:Point = touch.getLocation(parent);
				var previousPos:Point = touch.getPreviousLocation(parent);
				var delta:Point = currentPos.subtract(previousPos);
					
				this.width += delta.x;
				this.height += delta.y;
				
			}			
					
			
		}
		
	}
}