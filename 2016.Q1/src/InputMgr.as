package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.utils.Dictionary;

	public class InputMgr
	{
		
		//싱글톤
		private static var _instance:InputMgr;
		private static var _isConstructing:Boolean;
		
		public function InputMgr()
		{
			if (!_isConstructing) throw new Error("Singleton, use InputMgr.instance");
		}
		
		public static function get instance():InputMgr {
			if (_instance == null)  {
				_isConstructing = true;
				_instance = new InputMgr();
				_isConstructing = false;
			}
			return _instance;
		}
		
		
		
		
		
		/**
		 * 
		 * @param fileName = 해당 이름을 가진 파일을 열음 
		 * @return 데이터를 파싱하고 Vector에 저장하여 리턴
		 * 지정된 텍스트 파일을 읽어 파싱 후 Vector형태로 저장하는 메소드
		 */
		public function loadData(fileName:String):Vector.<PlayerInfo>
		{
			var info:Vector.<PlayerInfo>;
			info = new Vector.<PlayerInfo>;			
			
			var file:File = File.applicationDirectory;
			file = file.resolvePath(fileName);
						
			var stream:FileStreamWithLineReader = new FileStreamWithLineReader();
			stream.open(file, FileMode.READ);
			
			//같은 UTF-8로 인코딩 된 텍스트 파일 이라도 BOM이 있을 수도, 없을 수도 있네요...
			//제 경우엔 있어서 BOM을 제거하는 과정을 넣었습니다
			//String 클래스에서 BOM이 있는지 검사해주는 메소드가 있다면 참 좋을텐데...
			var isBOM:Boolean = true;
			
			while(stream.bytesAvailable)
			{
				var line:String = stream.readUTFLine();
				//trace(line);
				
				if(isBOM)
				{
					line = line.substr(1, line.length);
					isBOM = false;
				}
				if(line == "")
				{
					continue;
				}
				
				var tempInfo:PlayerInfo = savetoClass(line);
				info.push(tempInfo);	
			}
			
			stream.close();
			
			return info;
		}
		
		
		/**
		 * 
		 * @param line = 라인by라인으로 String을 받아옴
		 * @return 받아온 String을 파싱하여 PlayerInfo클래스의 멤버변수에 저장
		 * String을 받아와 파싱 후 PlayerInfo 클래스 멤버 변수에 저장하고 리턴하는 메소드
		 */
		private function savetoClass(line:String):PlayerInfo
		{
			var tempInfo:PlayerInfo = new PlayerInfo();
			
			var temp:Array = line.split(',');
			
			//불필요한 공백 제거
			for(var i:int=0; i<temp.length; ++i)
			{			
				//Name은 그대로
				if(i == 1)
					continue;
				
				var tempStr:String = temp[i];
				var myPattern:RegExp = new RegExp(/\D/g);
				tempStr = tempStr.replace(myPattern, "");
				temp[i] = tempStr;
				//trace(temp[i]);
			}			
			
			tempInfo.id = parseInt(temp[0]);
			tempInfo.name = temp[1];
			tempInfo.score = parseInt(temp[2]);
			tempInfo.win = parseInt(temp[3]);
			tempInfo.lose = parseInt(temp[4]);
			
			tempInfo.group = setGroupNum(tempInfo.score);
			
			return tempInfo;
		}
		
		
		/**
		 * 
		 * @param info = Vector로 저장된 데이터를 받아옴
		 * @return 리턴되는 Dictionary는 <int, Vector.<PlayerInfo> 형태 
		 * Vector.<PlayerInfo>를 받아와 해당 그룹에 Dictionary 형태로 저장하고  리턴하는 메소드
		 */
		public function saveToDictionary(info:Vector.<PlayerInfo>):Dictionary
		{
			var tempDic:Dictionary = new Dictionary();
			
			
			for(var i:int = 1; i <= 11; ++i)
			{
				var tempVec:Vector.<PlayerInfo> = new Vector.<PlayerInfo>;
				
				for(var j:int = 0; j<info.length; ++j)
				{
					//스코어 값을 토대로 그룹 매칭
					if(info[j].group == i)
					{
						tempVec.push(info[j]);
					}
				}	
				tempDic[i] = tempVec;				
			}			
			
			return tempDic;
		}
		
		/**
		 * 
		 * @param num : 데이터에서 가져온 점수를 파라미터로 받아옴
		 * @return 파라미터로 받은 정수를 계산하여 해당하는 그룹 번호를 리턴함
		 * score 백만 초과 -> 11리턴
		 * score 0이하     -> 0리턴
		 * 나머지                   -> 계산값 리턴
		 */
		public function setGroupNum(num:int):int
		{
			//Score를 10만으로 나눈 값을 그룹 번호로 함
			if(num > 1000000)
			{
				return 11;
			}
			
			if(num <= 0)
			{				
				return 0;
			}
			
			return ((num - 1) / 100000) + 1;
		}	
		
		
		
		
	}
}