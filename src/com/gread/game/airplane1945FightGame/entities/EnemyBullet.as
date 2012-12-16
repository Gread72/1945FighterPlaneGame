package com.gread.game.airplane1945FightGame.entities
{
	import org.flixel.FlxSprite;
	
	public class EnemyBullet extends FlxSprite
	{	
		[Embed(source="../assets/bulletEnemy.png")]
		private var bulletImg:Class;
		
		public function EnemyBullet(X:Number=0, Y:Number=0)
		{
			super(X, Y, bulletImg);
			
			velocity.y = 300;
		}
	}
}