package
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.display.Quad;
	import starling.utils.Color;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			//super();
			//var textField:TextField = new TextField(400,300,"Welcome to Starling");
			//addChild(textField);
			
			var quad:Quad = new Quad(200,200,Color.RED);
			quad.x = 100;
			quad.y = 50;
			addChild(quad);
		}
	}
}