package
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Window extends Sprite
	{
		[Embed(source = "contents.png")]
		private static const Contents:Class;
		
		[Embed(source = "titleBar.png")]
		private static const TitleBar:Class;
		
		
		public function Window()
		{
			//var bitmap:Bitmap = new Contents();
			//var texture:Texture = Texture.fromBitmap(bitmap)
			var contents:Image = new Image(Texture.fromEmbeddedAsset(Contents));
			var titleBar:Image = new Image(Texture.fromEmbeddedAsset(TitleBar));
			
			addChild(contents);
			addChild(titleBar);
		}
	}
}