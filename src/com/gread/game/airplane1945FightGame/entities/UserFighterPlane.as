package com.gread.game.airplane1945FightGame.entities
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class UserFighterPlane extends FlxSprite
	{
		static public var DIR_UP:String = "up";
		static public var DIR_DOWN:String = "down";
		static public var DIR_LEFT:String = "left";
		static public var DIR_RIGHT:String = "right";
		
		[Embed(source="../assets/1945_carved_22.png")]
		private var planeImg:Class;
		
		private var imgWidth:Number = 98;
		private var imgHeight:Number = 98;
		
		public function UserFighterPlane(X:Number=0, Y:Number=0)
		{
			super(X, Y, planeImg);
		}
		
		override public function update():void{
			velocity.x = 0;
			velocity.y = 0;
			
			if(FlxG.keys.UP){
				move(DIR_UP);
			}else if(FlxG.keys.DOWN){
				move(DIR_DOWN);
			}
			
			if(FlxG.keys.LEFT){
				move(DIR_LEFT);
			}else if(FlxG.keys.RIGHT){
				move(DIR_RIGHT);
			}
			
			super.update();
			
		}
		
		private function move(direction:String):void{
			switch(direction){
				case DIR_UP:
					velocity.y = -(2 * imgHeight);
				break;
				
				case DIR_DOWN:
					velocity.y = +(2 * imgHeight);
				break;
				
				case DIR_LEFT:
					velocity.x = -(2 * imgWidth);
				break;
				
				case DIR_RIGHT:
					velocity.x = +(2 * imgWidth);
					break;
			}
		}
	}
}