package com.gread.game.airplane1945FightGame.entities
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;
	
	public class BulletEmitter extends FlxEmitter
	{
		public function BulletEmitter(X:Number=0, Y:Number=0)
		{
			//super(X, Y);
			this.delay = 1;
			this.gravity = 0;
			this.maxRotation = 0;
			this.setXSpeed(-500, 500);
			this.setYSpeed(-500, 500);
			
			var particles: int = 10;
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xFF597137);
				particle.exists = false;
				this.add(particle);
			}
			
		}
	}
}