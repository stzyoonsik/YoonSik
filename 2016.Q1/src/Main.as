package
{	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class Main extends Sprite
	{
		//데이터를 가져올 텍스트 파일 이름
		private var fileName:String = "data.txt";
		
		//최대 몇 명까지 검색할 것인지를 저장하는 변수
		private const MAX_FINDABLE_PLAYER:int = 5;
		
		
		
		public function Main()
		{						
			//Data.txt에 들어있는 데이터를 파싱하여 vector 타입으로 저장
			var vecInfo:Vector.<PlayerInfo>;
			vecInfo = InputMgr.instance.loadData(fileName);
						
			
			//vector에 들어있는 데이터를 그룹화하여 Dictionary 타입으로 저장
			var dicInfo:Dictionary;
			dicInfo = InputMgr.instance.saveToDictionary(vecInfo);
			
			OutputMgr.instance.MAX_FINDABLE_PLAYER = MAX_FINDABLE_PLAYER;
			
			
			//사용자로부터 입력한 값을 토대로 탐색하고 정렬하며 출력			
			var capture:CaptureUserInput = new CaptureUserInput();			
			capture.dic = dicInfo;
			addChild(capture);
			
	
		}		


	}	
}