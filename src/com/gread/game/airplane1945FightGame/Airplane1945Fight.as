package com.gread.game.airplane1945FightGame
{
	import com.gread.game.airplane1945FightGame.states.GameState;
	import com.gread.game.airplane1945FightGame.states.MenuState;
	
	import org.flixel.FlxGame;
	
	[SWF(width="640",height="480",backgroundColor="#034a94")]
	[Frame(factoryClass="com.gread.game.airplane1945FightGame.Preloader")]
	public class Airplane1945Fight extends FlxGame
	{
		public static var STAGE_WIDTH:Number = 640;
		public static var STAGE_HEIGHT:Number = 480;
		
		public function Airplane1945Fight()
		{
			super(640, 480, MenuState, 1); 
		}
	}
}