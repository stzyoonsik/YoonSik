package
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
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
	}
}