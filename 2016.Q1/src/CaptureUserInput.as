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
		private var _textBox:TextField = new TextField(); 			//사용자로부터 입력받는 텍스트필드
		private var _outputBox:TextField = new TextField(); 		//출력하는 텍스트필드
		private var _text:String = ""; 
		
		private var _dic:Dictionary;
		
		
		public function set dic(setValue:Dictionary):void
		{
			_dic = setValue;			
		}
		
		
		public function CaptureUserInput() 
		{ 
			captureText(); 
		} 
		
		/**
		 * 사용자로부터 스코어 값을 받는 텍스트필드를 세팅하는 메소드
		 * 
		 */
		public function captureText():void 
		{ 
			_textBox.type = TextFieldType.INPUT; 
			_textBox.border = true;
			_textBox.background = true; 
			_textBox.height = 20;
			addChild(_textBox); 
			_textBox.text = _text; 
			_textBox.addEventListener(KeyboardEvent.KEY_DOWN, textInputCapture); 
		} 
		
		
		/**
		 * 
		 * @param event 키보드 입력이 들어오는 순간 발생
		 * 
		 */
		public function textInputCapture(event:KeyboardEvent):void 
		{ 			
			//입력 텍스트 필드가 비어있지 않으며, 엔터를 입력받는 경우 (숫자가 포함되어있지 않으면 에러)
			if(event.charCode == Keyboard.ENTER && _textBox.text != "")				
			{
				//숫자가 하나라도 있을 경우에만 
				if(_textBox.text.match("[0-9]") != null)
				{
					OutputMgr.instance.textField.text = "";
					OutputMgr.instance.foundPlayerCount = 0;
					
					var str:String = _textBox.text; 				
					
					var myPattern:RegExp = new RegExp(/\D/g);
					str = str.replace(myPattern, "");
					
					//사용자로부터 입력받은 String을 int로 형변환 	
					OutputMgr.instance.inputScore = int(str);
					createOutputBox();
				}
				
			}
		} 
		
		/**
		 * 
		 * OutputMgr을 통해 받아온 String 텍스트를 화면에 출력하는 메소드
		 */
		public function createOutputBox():void 
		{ 			
			_outputBox.border = true;
			_outputBox.background = true; 
			_outputBox.y = 50; 
			_outputBox.autoSize = "left";
			addChild(_outputBox); 
			
			OutputMgr.instance.printScoreAndGroup();
			OutputMgr.instance.seekGroup(_dic);
			_outputBox.text = OutputMgr.instance.textField.text;
		} 
	}
}