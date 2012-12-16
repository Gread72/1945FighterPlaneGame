package com.gread.game.airplane1945FightGame.entities
{
	import org.flixel.FlxSprite;
	
	public class LargeExplosionEntity extends FlxSprite
	{
		public static var WIDTH:Number = 65;
		public static var HEIGHT:Number = 65;
		
		[Embed(source="../assets/explosionImgLarge.png")]
		private var explodeImg:Class;
		
		public function LargeExplosionEntity(xPos:Number=0, yPos:Number=0){
			//super(x, y, planeImg);
			x = xPos;
			y = yPos;
			
			// Loading the image.
			this.loadGraphic(explodeImg, true, false, WIDTH, HEIGHT);
			
			// Setting up the animations.
			addAnimation("DOWN_IDLE", [0,6], 6);
			//addAnimation("UP_IDLE", [5]);
			//addAnimation("LEFT_IDLE", [0]);
			//addAnimation("RIGHT_IDLE", [0]);
			
			//this.addAnimationCallback(onAniCallback);
			
			velocity.y = 50;
			play("DOWN_IDLE");
		}
		
		override public function update():void{
			if(this.finished){
				//play("UP_IDLE");
				
				this.destroy();
				this.alpha = 0;
			}
			
			super.update();
		}
	}
}