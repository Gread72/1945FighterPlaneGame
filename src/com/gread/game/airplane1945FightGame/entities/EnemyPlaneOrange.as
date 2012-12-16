package com.gread.game.airplane1945FightGame.entities
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class EnemyPlaneOrange extends FlxSprite implements IEnemyPlane
	{	
		static public var DIR_UP:String = "up";
		static public var DIR_DOWN:String = "down";
		static public var DIR_LEFT:String = "left";
		static public var DIR_RIGHT:String = "right";
		static public var DIR_LIFT_UP:String = "liftUp";
		
		public static var WIDTH:Number = 32;
		public static var HEIGHT:Number = 32;
		
		[Embed(source="../assets/OrangeEnemyPlane.png")]
		private var planeImg:Class;
		
		private var imgWidth:Number = WIDTH;
		private var imgHeight:Number = HEIGHT;
		
		private var _hasFiredBullet:Boolean = false;
		private var _firePoint:FlxPoint;
		
		private var _bulletFired:Boolean = false;
		
		public function EnemyPlaneOrange(xPos:Number=0, yPos:Number=0)
		{
			//super(x, y, planeImg);
			x = xPos;
			y = yPos;
			
			// Loading the image.
			this.loadGraphic(planeImg, true, false, imgWidth, imgHeight);
			
			// Setting up the animations.
			addAnimation("DOWN_IDLE", [0,1], 6);
			//addAnimation("UP_IDLE", [0]);
			//addAnimation("LEFT_IDLE", [0]);
			//addAnimation("RIGHT_IDLE", [0]);
			
		}
		
		public function startPlane():void{
			play("DOWN_IDLE");
			velocity.y = 200;
		}
		
		public function get bulletFired():Boolean
		{
			return _bulletFired;
		}
		
		public function set bulletFired(value:Boolean):void
		{
			_bulletFired = value;
		}
	}
}