package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	public class CaptureUserInput extends Sprite
	{
		private var myTextBox:TextField = new TextField(); 			//사용자로부터 입력받는 텍스트필드
		private var myOutputBox:TextField = new TextField(); 		//출력하는 텍스트필드
		private var myText:String = ""; 
		
		private var dic:Dictionary = new Dictionary();
		
		
		public function set Dic(setValue:Dictionary):void
		{
			dic = setValue;
		}
		
		
		public function CaptureUserInput() 
		{ 
			captureText(); 
		} 
		
		public function captureText():void 
		{ 
			myTextBox.type = TextFieldType.INPUT; 
			myTextBox.border = true;
			myTextBox.background = true; 
			myTextBox.height = 20;
			addChild(myTextBox); 
			myTextBox.text = myText; 
			myTextBox.addEventListener(KeyboardEvent.KEY_DOWN, textInputCapture); 
		} 
		
		//키보드 입력이 들어오는 순간 발생
		public function textInputCapture(event:KeyboardEvent):void 
		{ 			
			//입력 텍스트 필드가 비어있지 않으며, 엔터를 입력받는 경우 (숫자가 포함되어있지 않으면 에러)
			if(event.charCode == Keyboard.ENTER && myTextBox.text != "")				
			{
				//숫자가 하나라도 있을 경우에만 
				if(myTextBox.text.match("[0-9]") != null)
				{
					OutputMgr.instance.textField.text = "";
					OutputMgr.instance.foundPlayerCount = 0;
					
					var str:String = myTextBox.text; 				
					
					var myPattern:RegExp = new RegExp(/\D/g);
					str = str.replace(myPattern, "");
					
					//사용자로부터 입력받은 String을 int로 형변환 	
					OutputMgr.instance.inputScore = int(str);
					createOutputBox(str);
				}
				
			}
		} 
		
		public function createOutputBox(str:String):void 
		{ 			
			myOutputBox.border = true;
			myOutputBox.background = true; 
			myOutputBox.y = 50; 
			myOutputBox.autoSize = "left";
			addChild(myOutputBox); 
			
			OutputMgr.instance.PrintScoreAndGroup();
			OutputMgr.instance.SeekGroup(dic);
			myOutputBox.text = OutputMgr.instance.textField.text;
		} 
	}
}