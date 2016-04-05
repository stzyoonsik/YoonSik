package
{
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
				
	
	}
}