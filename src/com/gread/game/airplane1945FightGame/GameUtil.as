package com.gread.game.airplane1945FightGame
{
	public class GameUtil
	{
		public function GameUtil(){}
		
		public static function leadingZeros(value:uint, places:Number):String{
			var result:String = value.toString();
			while ( result.length < places ) {
				result = '0' + result;
			}
			return result;
		}
		
		public static var currentHiScore:Number = 0;
	}
}