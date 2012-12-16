package com.gread.game.airplane1945FightGame.entities
{
	import org.flixel.FlxSprite;
	
	public class UserFighterBullet extends FlxSprite
	{	
		[Embed(source="../assets/bullet.png")]
		private var bulletImg:Class;
		
		public function UserFighterBullet(X:Number=0, Y:Number=0)
		{
			super(X, Y, bulletImg);
			
			velocity.y = -200;
		}
	}
}