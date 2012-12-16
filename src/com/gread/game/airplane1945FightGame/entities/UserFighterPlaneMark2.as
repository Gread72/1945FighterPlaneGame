package com.gread.game.airplane1945FightGame.entities
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	public class UserFighterPlaneMark2 extends FlxSprite
	{
		static public var DIR_UP:String = "up";
		static public var DIR_DOWN:String = "down";
		static public var DIR_LEFT:String = "left";
		static public var DIR_RIGHT:String = "right";
		static public var DIR_LIFT_UP:String = "liftUp";
		
		public static var WIDTH:Number = 78;
		public static var HEIGHT:Number = 63;
		
		[Embed(source="../assets/UserFighterPlaneImg.png")]
		private var planeImg:Class;
		
		private var imgWidth:Number = WIDTH;
		private var imgHeight:Number = HEIGHT;
		
		private var _hasFiredBullet:Boolean = false;
		private var _firePoint:FlxPoint;
		
		private var _animateSetupDone:Boolean = false;
		
		public function UserFighterPlaneMark2(x:Number=0, y:Number=0)
		{
			
			//super(x, y, planeImg);
			
			this.x = x;
			this.y = y;
			
			// Loading the image.
			this.loadGraphic(planeImg, true, false, imgWidth, imgHeight);
			
			// Setting up the animations.
			addAnimation("DOWN_IDLE", [0, 1], 6);
			addAnimation("UP_IDLE", [0, 1], 6);
			addAnimation("LEFT_IDLE", [0, 1], 6);
			addAnimation("RIGHT_IDLE", [0, 1], 6);
			
			addAnimation("LIFT_UP", [3, 2, 1], 6, false);
			addAnimation("DOWN", [3]);
			//addAnimation("UP_WALK", [4,5], 6);
			//addAnimation("LEFT_WALK", [7,8], 6);
			//addAnimation("RIGHT_WALK", [10,11], 6);
			
			play("DOWN");
		}
		
		public function get animateSetupDone():Boolean
		{
			return _animateSetupDone;
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
			
			if(FlxG.keys.SHIFT){
				move(DIR_LIFT_UP);
			}
			
			if(FlxG.keys.justPressed("SPACE")){
				_hasFiredBullet = true;
				// to fire from both sides randomly
				var gunSideX:Number = x + 10; 
				if(Math.round( FlxU.random()  * 2 ) == 2){
					gunSideX = gunSideX + 28;
				}
				_firePoint = new FlxPoint(gunSideX, y - 10);
			}
			
			//animation setup
			if(!_animateSetupDone){
				if(this.y <= 350){
					play("LIFT_UP");
					_animateSetupDone = true;
				}
				
				velocity.y = -200;
			}
			
			super.update();
			
		}
		
		public function getFiredStatus():FlxPoint{
			if(_hasFiredBullet){
				_hasFiredBullet = false;
			}	
			return _firePoint;
		}
		
		public function hasFiredBullet():Boolean{
			return _hasFiredBullet;
		}
		
		private function move(direction:String):void{
			switch(direction){
				case DIR_UP:
					velocity.y = -(2 * imgHeight);
					play("UP_IDLE");
					break;
				
				case DIR_DOWN:
					velocity.y = +(2 * imgHeight);
					play("DOWN_IDLE");
					break;
				
				case DIR_LEFT:
					velocity.x = -(2 * imgWidth);
					play("LEFT_IDLE");
					break;
				
				case DIR_RIGHT:
					velocity.x = +(2 * imgWidth);
					play("RIGHT_IDLE");
					break;
				
				case DIR_LIFT_UP:
					play("LIFT_UP");
					break;
			}
		}
	}
}