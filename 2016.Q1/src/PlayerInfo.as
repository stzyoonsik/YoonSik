package
{
	public class PlayerInfo 
	{
		private var _id:int;									
		private var _name:String;
		private var _score:int;
		private var _win:int;
		private var _lose:int;
		private var _group:int;
		
		
		//getter setter 

		public function get group():int
		{
			return _group;
		}

		public function set group(value:int):void
		{
			_group = value;
		}

		public function get id():int
		{
			return _id;
		}
		
		public function set id(setValue:int):void
		{
			_id = setValue;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(setValue:String):void
		{
			_name = setValue;
		}
		
		public function get score():int
		{
			return _score;
		}
		
		public function set score(setValue:int):void
		{
			_score = setValue;
		}
		
		public function get win():int
		{
			return _win;
		}
		
		public function set win(setValue:int):void
		{
			_win = setValue;
		}
		
		
		public function get lose():int
		{
			return _lose;
		}
		
		public function set lose(setValue:int):void
		{
			_lose = setValue;
		}		
		

	}
}