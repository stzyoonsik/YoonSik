package
{
	import flash.geom.Point;
	import flash.system.System;
	
	import ResourceLoader;
	
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
		private var _contents:Image;
		private var _titleBar:Image;
		private var _minimize:Image;
		private var _revert:Image;
		private var _close:Image;
		private var _border:Image;
		
		private var _texture:Texture; 
		private var _xml:XML; 
		private var _atlas:TextureAtlas; 
		
		private var _movie:MovieClip; 		
			
		private var _textField:TextField = new TextField(70,30);
		
		private var _spr:Sprite = new Sprite();		
		
		private var _childWindow:Window;
		private var _vecChild:Vector.<Window> = new Vector.<Window>;
		private var _num:int = 0;
		
		
		public function Window()
		{			
			
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
			
			loadResource();			
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
			
			Starling.juggler.add(_movie);
			addChild(_movie);
			
			trace(System.totalMemory / 1024);
			
		}	
		
		/**
		 * 
		 * 리소스 로드 메소드 
		 */
		private function loadResource():void
		{
			_contents = new Image(Texture.fromEmbeddedAsset(ResourceLoader.Contents));
			_titleBar = new Image(Texture.fromEmbeddedAsset(ResourceLoader.TitleBar));
			_minimize = new Image(Texture.fromEmbeddedAsset(ResourceLoader.Minimize));
			_revert   = new Image(Texture.fromEmbeddedAsset(ResourceLoader.Revert));
			_close    = new Image(Texture.fromEmbeddedAsset(ResourceLoader.Close));
			_border   = new Image(Texture.fromEmbeddedAsset(ResourceLoader.Border));
			
			_texture  = Texture.fromEmbeddedAsset(ResourceLoader.AtlasTexture);
			_xml      = XML(new ResourceLoader.AtlasXml);
			_atlas    = new TextureAtlas(_texture, _xml);
			
			_movie    = new MovieClip(_atlas.getTextures("walk-right_"), 6);
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
			
			_minimize.x = _titleBar.width - 96;
			_minimize.y = _titleBar.y;
			
			_revert.x = _titleBar.width - 64;
			_revert.y = _titleBar.y;
			
			_close.x = _titleBar.width - 32;
			_close.y = _titleBar.y;
			
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
			_spr.addEventListener(TouchEvent.TOUCH, onTouchTitleBar);
			_minimize.addEventListener(TouchEvent.TOUCH, onMinimize);
			_revert.addEventListener(TouchEvent.TOUCH, onRevert);
			_close.addEventListener(TouchEvent.TOUCH, onClose);
			_contents.addEventListener(TouchEvent.TOUCH, onMakeChild);
			
			_border.addEventListener(TouchEvent.TOUCH, onChangeScale);
			
			_movie.addEventListener(TouchEvent.TOUCH, onHoverCharacter);
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
				_movie.visible = false;
				_border.visible = false;
				
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
				_movie.visible = true;
				_border.visible = true;
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
				
				trace("_vecChild.length = " + _vecChild.length);
				
				release();
			}
		}
		
		/**
		 * 7
		 * @param e 터치이벤트
		 * 터치 이벤트가 발생하면 콜백되는 메소드
		 * 터치 이벤트가 발생하면 드래그 앤 드롭을 통해 오브젝트들을 이동시켜주는 메소드
		 */
		private function onTouchTitleBar(e:TouchEvent):void
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
			
			
			//그냥 클릭했을 경우, 현재 선택된 윈도우가 가장 위에 보이게 함
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
					
				
				_border.width += delta.x;
				_titleBar.width += delta.x;	
				_contents.width += delta.x;
				_minimize.x = _titleBar.width - 96;
				_revert.x = _titleBar.width - 64;
				_close.x = _titleBar.width - 32;				
				
				_border.height += delta.y;				
				//_movie.height += delta.y;
				_contents.height += delta.y;
				
				//보더가 타이틀바보다 작아지는것에 대한 예외처리
				if(_border.height < _titleBar.height + 10)
					_border.height = _titleBar.height + 10;
				
				//if(_movie.height < 50)
				//	_movie.height = 50;
			}	
		}
		
		/**
		 * 
		 * 케릭터에 마우스가 Hover되면 케릭터를 오른쪽으로 이동시키는 콜백 메소드
		 */
		private function onHoverCharacter():void
		{
			_movie.x += 1;
			
			//벽에 닿으면 처음 위치로
			if(_movie.x > _contents.width - _movie.width)
				_movie.x = _contents.x;
		}
		
		/**
		 * 
		 * 재귀적으로 메모리를 release하는 메소드
		 */
		private function release():void
		{
			for(var i:int = 0; i<_vecChild.length; ++i)
			{
				_vecChild[i].removeEventListeners(TouchEvent.TOUCH);					
				_vecChild[i].removeEventListener(TouchEvent.TOUCH, onAddedEvents);
				_vecChild[i].removeFromParent();
				_vecChild[i].removeChildren();
				_vecChild[i].dispose();
				_vecChild[i].release();
				
			}
			trace(System.totalMemory / 1024);
			//_vecChild.pop();
			
			this.removeEventListeners(TouchEvent.TOUCH);
			this.removeEventListener(TouchEvent.TOUCH, onAddedEvents);
			this.removeFromParent();	
			this.removeChildren();
			this.dispose();			
		}
	}
}