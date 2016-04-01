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
		
		
		
		
		//지정된 텍스트 파일을 읽어 파싱 후 Vector형태로 저장하는 메소드
		public function LoadData(fileName:String):Vector.<PlayerInfo>
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
				
				var tempInfo:PlayerInfo = SavetoClass(line);
				info.push(tempInfo);	
			}
			
			return info;
		}
		
		//String을 받아와 파싱 후 PlayerInfo 클래스 멤버 변수에 저장하고 리턴하는 메소드
		private function SavetoClass(line:String):PlayerInfo
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
			
			return tempInfo;
		}
		
		//Vector.<PlayerInfo>를 받아와 해당 그룹에 Dictionary 형태로 저장하고  리턴하는 메소드
		public function SaveToDictionary(info:Vector.<PlayerInfo>):Dictionary
		{
			var tempDic:Dictionary = new Dictionary();
			
			
			for(var i:int = 1; i <= 11; ++i)
			{
				var tempVec:Vector.<PlayerInfo> = new Vector.<PlayerInfo>;
				
				for(var j:int = 0; j<info.length; ++j)
				{
					//스코어 값을 토대로 그룹 매칭
					if(SetGroupNum(info[j].score) == i)
					{					
						tempVec.push(info[j]);
					}					
				}	
				tempDic[i] = tempVec;				
			}			
			
			return tempDic;
		}
		
		
		public function SetGroupNum(num:int):int
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
		
		
		
		public function SaveToTxt():void
		{
			
		}
		
		
	}
}