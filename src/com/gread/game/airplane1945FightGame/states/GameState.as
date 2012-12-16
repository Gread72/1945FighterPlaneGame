package com.gread.game.airplane1945FightGame.states
{
	
	import com.gread.game.airplane1945FightGame.Airplane1945Fight;
	import com.gread.game.airplane1945FightGame.GameUtil;
	import com.gread.game.airplane1945FightGame.entities.BulletEmitter;
	import com.gread.game.airplane1945FightGame.entities.EnemyBullet;
	import com.gread.game.airplane1945FightGame.entities.EnemyPlaneBlue;
	import com.gread.game.airplane1945FightGame.entities.EnemyPlaneOrange;
	import com.gread.game.airplane1945FightGame.entities.IEnemyPlane;
	import com.gread.game.airplane1945FightGame.entities.LargeExplosionEntity;
	import com.gread.game.airplane1945FightGame.entities.SmallExplosionEntity;
	import com.gread.game.airplane1945FightGame.entities.UserFighterBullet;
	import com.gread.game.airplane1945FightGame.entities.UserFighterPlane;
	import com.gread.game.airplane1945FightGame.entities.UserFighterPlaneMark2;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	public class GameState extends FlxState
	{
		private var _title:FlxText;
		private var _player:UserFighterPlane;
		private var _playerChar:UserFighterPlaneMark2;
		
		private var _bullets:FlxGroup;
		private var _enemyBullets:FlxGroup;
		
		private var _enemyShips:FlxGroup;
		
		private var _userShips:FlxGroup;
		
		private const TARGET_NUMBER:Number = 100;
		
		// Loading the map.
		[Embed(source = "../assets/oceanMap.txt", mimeType = "application/octet-stream")] 
		private var txtMap:Class;
		
		// Loading the map spritesheet.
		[Embed(source = "../assets/oceanTileMap_1.png")] 
		private var imgMap:Class;
		
		// Map variable
		public var map:FlxTilemap;
		
		[Embed(source = "../assets/smallTitleLogo.png")] 
		private var smallTitleLogoImg:Class;
		
		[Embed(source = "../assets/ExplosionAlien.mp3")] 
		private var enemyExplosionMP3:Class;
		
		[Embed(source = "../assets/ExplosionShip.mp3")] 
		private var userExplosionMP3:Class;
		
		private var enemyEnteredScreen:Boolean = true;
		
		private var _enemyPlaneHitMissed:Number = 0;
		private var isGameOver:Boolean = false;
		
		public function GameState()
		{
			super();
		}
		
		override public function create():void{
			FlxG.score = 0;
			
			FlxU.setWorldBounds(0, 0, Airplane1945Fight.STAGE_WIDTH, Airplane1945Fight.STAGE_HEIGHT);
			
			map = new FlxTilemap();
			map.startingIndex = 0;
			map.drawIndex = 0;
			map.loadMap(new txtMap,imgMap, 32, 32);
			add(map);
			map.y = -6600;
			
			_title = new FlxText(10, 10, 200, "Score: 000");
			_title.setFormat(null, 12, 0xFFFFFF);
			add(_title);
			
			var _smalltitleLogo:FlxSprite = new FlxSprite(Airplane1945Fight.STAGE_WIDTH - 120, 5, smallTitleLogoImg);
			add(_smalltitleLogo);
			var _smalltitleLogoText:FlxText = new FlxText(_smalltitleLogo.x + 5, 58 - 10, 115, "Airplaine FIGHT!");
			add(_smalltitleLogoText);
			
			_playerChar = new UserFighterPlaneMark2(Airplane1945Fight.STAGE_WIDTH/2 - (UserFighterPlaneMark2.WIDTH / 2), 600);
			add(_playerChar);
			
			_bullets = new FlxGroup();
			add(_bullets);
			
			_enemyShips = new FlxGroup();
			add(_enemyShips);
			
			_enemyBullets = new FlxGroup();
			add(_enemyBullets);
			
			// Show mouse.
			FlxG.mouse.hide();
			
			super.create();
		}
		
		override public function update():void{
			if(!isGameOver){
				if(_playerChar.animateSetupDone){
					handleUserFire();
					
					handleEnemyShips();
					
					FlxU.overlap(_enemyShips, _playerChar, overlapUserEnemyShip);
					
					FlxU.overlap(_enemyShips, _bullets, overlapUserBullet);
					
					FlxU.overlap(_playerChar, _enemyBullets, overlapEnemyBullet);
				}
				
				map.velocity.y = +10;
				
				if(_enemyPlaneHitMissed == TARGET_NUMBER){
					isGameOver = true;
				}
			}else{
				showRestartButton();
			}
			super.update();
		}
		
		private function handleUserFire():void{
			if(_playerChar.hasFiredBullet() && _bullets.members.length < 4){
				var userBullet:FlxPoint = _playerChar.getFiredStatus();
				_bullets.add(new UserFighterBullet(userBullet.x, userBullet.y) );
			}
			
			// remove bullets when it reaches the top area.
			for each (var item:UserFighterBullet in _bullets.members){
				if(item && item.y < 0){
					item.kill();
					_bullets.remove(item, true);
				}
			}
		}
		
		private function handleEnemyShips():void{
			if(enemyEnteredScreen){
				_enemyShips.add( createEnemyPlane() as FlxSprite );
				enemyEnteredScreen = false;
			}
			
			// remove bullets when it reaches the top area.
			for each (var item2:IEnemyPlane in _enemyShips.members){
				
				FlxSprite(item2).velocity.x =  _playerChar.x - FlxSprite(item2).x;
				
				if(!item2.bulletFired && item2 is EnemyPlaneOrange){
					_enemyBullets.add( new EnemyBullet(FlxSprite(item2).x + 8, FlxSprite(item2).y) );
					item2.bulletFired = true;
				}
				
				if(item2 && FlxSprite(item2).y > Airplane1945Fight.STAGE_HEIGHT){
					FlxSprite(item2).kill();
					_enemyShips.remove(FlxSprite(item2), true);
					enemyEnteredScreen = true;
					_enemyPlaneHitMissed++;
				}
				
			}
		}
		
		private function createEnemyPlane():IEnemyPlane{
			var enemyPlane:IEnemyPlane;
			if(Math.round( FlxU.random()  * 2 ) == 1){
				enemyPlane = new EnemyPlaneOrange(_playerChar.x, -32);
			}else{
				enemyPlane = new EnemyPlaneBlue(_playerChar.x + 200, -32);
			}
			
			enemyPlane.startPlane();
			
			return enemyPlane;
		}
		
		private function overlapUserEnemyShip(enemy:IEnemyPlane, userShip:UserFighterPlaneMark2):void{
			FlxG.play(userExplosionMP3);
			
			FlxG.quake.start();
			
			var anim:LargeExplosionEntity = new LargeExplosionEntity(userShip.x, userShip.y)
			add(anim);
			
			var emitter:FlxEmitter = new BulletEmitter();
			add(emitter);
			emitter.at(FlxSprite(enemy));
			emitter.start();
			
			FlxSprite(enemy).kill();
			userShip.kill();
			
			enemyEnteredScreen = true;
			
			showRestartButton();
		}
		
		private function overlapEnemyBullet(userShip:UserFighterPlaneMark2, enemyBullet:EnemyBullet):void{
			FlxG.play(userExplosionMP3);
			FlxG.quake.start();
			
			var anim:LargeExplosionEntity = new LargeExplosionEntity(userShip.x, userShip.y)
			add(anim);
			
			var emitter:FlxEmitter = new BulletEmitter();
			add(emitter);
			emitter.at(FlxSprite(enemyBullet));
			emitter.start();
			
			FlxSprite(enemyBullet).kill();
			userShip.kill();
			_enemyBullets.remove(enemyBullet, true);
			
			showRestartButton();
			
		}
		
		private function showRestartButton():void{
			var restartButton:FlxButton = new FlxButton(Airplane1945Fight.STAGE_WIDTH/2 - 100/2, Airplane1945Fight.STAGE_HEIGHT/2, restartGame);
			restartButton.width = 600;
			var responseText:String = "Restart Game";
			if(_enemyPlaneHitMissed == TARGET_NUMBER){
				responseText = responseText + "\n\n   You Won!"
			}
			var restartButtonText:FlxText = new FlxText(0,2,120,responseText);
			restartButtonText.setFormat(null, 12, 0x000000);
			restartButton.loadText(restartButtonText);
			add(restartButton);
			FlxG.mouse.show();
			
			if(FlxG.score > GameUtil.currentHiScore){
				GameUtil.currentHiScore = FlxG.score;
			}
			
			map.velocity.y = 0;
		}
		
		private function restartGame():void{
			FlxG.state = new MenuState();
		}
		
		private function overlapUserBullet(enemy:IEnemyPlane, bullet:UserFighterBullet):void{
			FlxG.play(enemyExplosionMP3);
			
			var emitter:FlxEmitter = new BulletEmitter();
			add(emitter);
			emitter.at(FlxSprite(enemy));
			emitter.start();
			
			FlxSprite(enemy).kill();
			bullet.kill();
			_bullets.remove(bullet, true);
			enemyEnteredScreen = true;
			
			var anim:SmallExplosionEntity = new SmallExplosionEntity(FlxSprite(enemy).x, FlxSprite(enemy).y)
			add(anim);
			
			_enemyPlaneHitMissed++;
			FlxG.score += 1;
			_title.text = "Score: " + GameUtil.leadingZeros(FlxG.score, 3);
		}
		
	}
}