package
{	
	import flash.text.TextField;
	import flash.utils.Dictionary;

	public class OutputMgr 
	{
		//싱글톤
		private static var _instance:OutputMgr;
		private static var _isConstructing:Boolean;
		
		public function OutputMgr()
		{
			if (!_isConstructing) throw new Error("Singleton, use OutputMgr.instance");
		}
		
		

		public static function get instance():OutputMgr {
			if (_instance == null)  {
				_isConstructing = true;
				_instance = new OutputMgr();
				_isConstructing = false;
			}
			return _instance;
		}		
		
		
		public var foundPlayerCount:int;
		public var textField:TextField = new TextField();
		public var inputScore:int;
		public var MAX_FINDABLE_PLAYER:int;
		
		
		
	
		
		
		
		/**
		 * 
		 * @param groupNum = 입력받은 그룹 번호를 출력
		 * @param info = 입력받은 Vector안에 있는 클래스 데이터를 출력
		 * 최종적으로 출력하는 메소드
		 */
		private function printResult(groupNum:int, info:Vector.<PlayerInfo>):void
		{
			if(info.length != 0)
			{
				trace("\n> Matched Group: " + groupNum + " (" + info.length + " players)");
				textField.text += "\n> Matched Group: " + groupNum + " (" + info.length + " players)\n";
			}
			
			for(var i:int = 0; i<info.length; ++i)
			{	
				trace("\tUser(id: " + info[i].id +
					", name: " + info[i].name +
					", score: " + info[i].score +
					", win: " + info[i].win + 
					", lose: " + info[i].lose +
					")");		
				
				textField.text += "\tUser(id: " + info[i].id +
					", name: " + info[i].name +
					", score: " + info[i].score +
					", win: " + info[i].win + 
					", lose: " + info[i].lose +
					")\n";	
			}	
		}
		
		/**
		 * 사용자로부터 입력받은 스코어를 출력
		 * 그 스코어를 토대로 한 그룹번호를 출력 하는 메소드
		 */
		public function printScoreAndGroup():void
		{
			trace("Input Your Score : " + inputScore);
			trace("Your Group : " + InputMgr.instance.setGroupNum(inputScore));
			
			textField.text += "Input Your Score : " + inputScore + "\n";
			textField.text += "Your Group : " + InputMgr.instance.setGroupNum(inputScore) + "\n";
		}
		
		
		
		/**
		 * 
		 * @param dic = Dictionary형태로 저장된 데이터를 가져옴
		 * 정해진 탐색순서에 따라 최대 n명의 플레이어를 검색하고 출력하는 메소드
		 */
		public function seekGroup(dic:Dictionary):void
		{		
			
			var arrGroup:Array = dicideGroupOrder(InputMgr.instance.setGroupNum(inputScore));	
			
			//trace("그룹 탐색 순서 = " + arrGroup);	
		
			var isFoundAll:Boolean = false;
			
			for(var i:int = 0; i<arrGroup.length; ++i)
			{
				var vecTemp:Vector.<PlayerInfo> = dic[arrGroup[i]];
				
				//플레이어의 스코어와 인풋스코어의 차이값을 기준으로 오름차순 정렬
				vecTemp.sort(orderByGap);
				
				foundPlayerCount+= vecTemp.length;
				
				if(foundPlayerCount > MAX_FINDABLE_PLAYER - 1)
				{
					//n명보다 많은 수의 플레이어가 탐색되었을 때, 뒤에서부터 초과된 만큼 삭제
					for(var j:int = 0; j<foundPlayerCount - MAX_FINDABLE_PLAYER; ++j)
					{							
						vecTemp.pop();
					}	
					isFoundAll = true;
				}
				
				printResult(arrGroup[i], vecTemp);
				
				if(isFoundAll)
					break;
			}
			
		}
		
		
		/**
		 * 
		 * @param infoA 
		 * @param infoB
		 * @return 
		 * 저장 된 스코어와 사용자로부터 입력받은 스코어의 차이의 절대값을 비교함
		 * 사용자 정의 정렬 메소드 (오름차순)
		 * 
		 */
		private function orderByGap(infoA:PlayerInfo, infoB:PlayerInfo):int
		{			
			var tempA:int = Math.abs(infoA.score - inputScore);
			var tempB:int = Math.abs(infoB.score - inputScore);					
			
			if(tempA < tempB)
				return -1;
			
			else if(tempA > tempB)
				return 1;
			
			else		
				return 0;
		}		

		
		
		/**
		 * 
		 * @param num = 사용자로부터 입력받은 스코어
		 * @return Array형태로 0번 인덱스에는 처음 탐색할 그룹, 1번 인덱스에는 그 다음 탐색할 그룹... 을 리턴
		 * 사용자로부터 입력받은 점수를 토대로 그룹 탐색 순서를 정하는 메소드		
		 */
		private function dicideGroupOrder(num:int):Array
		{
			var isPlusOver:Boolean;
			var isMinusOver:Boolean;			
			var tempNum:int = num;			
			var arrGroup:Array = new Array(11);
			
			//arrGroup[0] ~ arrGroup[10] 까지 검색 순서를 넣는다
			for(var i:int = 0; i < arrGroup.length; ++i)
			{				
				arrGroup[i] = tempNum;
				//넣을 그룹 번호가 1보다 작아지는 경우
				if(isMinusOver)
				{					
					tempNum++;
					continue;
				}
				//넣을 그룹 번호가 11보다 커지는 경우
				if(isPlusOver)
				{					
					tempNum--;
					continue;
				}								
				
				if(!isMinusOver && !isPlusOver)
				{						
					//짝수 인덱스
					if(i % 2 == 0)
					{				
						tempNum += i + 1;
						
						if(tempNum > 11)
						{
							isPlusOver = true;
							tempNum -= i + 2;
						}
					}
					
					else
					{
						tempNum -= i + 1;
						
						if(tempNum < 1)
						{
							isMinusOver = true;
							tempNum += i + 2;
						}	
					}
				}
			}
			return arrGroup;
		}
		
	}
}