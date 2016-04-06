package
{
	//import flash.display.Bitmap;
	//import flash.display.Loader;
	//import flash.net.URLRequest;
	
	//import starling.textures.Texture;

	public class ResourceLoader
	{
		
		[Embed(source = "../images/contents.png")]
		public static const Contents:Class;
		
		[Embed(source = "../images/titleBar.png")]
		public static const TitleBar:Class;
		
		[Embed(source = "../images/minimize.png")]
		public static const Minimize:Class;
		
		[Embed(source = "../images/revert.png")]
		public static const Revert:Class;
		
		[Embed(source = "../images/close.png")]
		public static const Close:Class;
		
		[Embed(source = "../images/border.png")]
		public static const Border:Class;
		
		[Embed(source = "TextureAtlas.xml", mimeType="application/octet-stream")]
		public static const AtlasXml:Class;
		
		[Embed(source = "../images/walk-right.png")]
		public static const AtlasTexture:Class;
				
		
		
//		public static var titleBar:Texture;
//		
//		private var titleBarLoader:Loader = new Loader();
//		private var titleBarURL:URLRequest = new URLRequest("../images/titleBar.png");
//		private var titleBarBitmap:Bitmap = new Bitmap();
//		
//		public function ResourceLoader()
//		{
//			titleBarLoader.load(titleBarURL);
//			titleBar = Texture.fromBitmap(titleBarBitmap);				
//		}
	}
}