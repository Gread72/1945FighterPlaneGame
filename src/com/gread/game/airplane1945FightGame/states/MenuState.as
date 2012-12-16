package com.gread.game.airplane1945FightGame.states
{
	import com.gread.game.airplane1945FightGame.Airplane1945Fight;
	import com.gread.game.airplane1945FightGame.GameUtil;
	import com.gread.game.airplane1945FightGame.states.GameState;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	public class MenuState extends FlxState
	{
		
		[Embed(source = "../assets/TitleLogo.png")] 
		private var titleLogoImg:Class;
		
		public function MenuState()
		{
			super();
		}
		
		override public function create():void{
			//bgColor = 0;
			
			var _oneUpText:FlxText = new FlxText(20, 5, 250, "1UP \n" + GameUtil.leadingZeros(FlxG.scores[0], 3));
			_oneUpText.setFormat(null, 18, 0xFFFFFF);
			add(_oneUpText)
			
			var _highScoreText:FlxText = new FlxText(_oneUpText.x + _oneUpText.width + 10, 5, 300, "HI SCORE \n" + GameUtil.leadingZeros(GameUtil.currentHiScore, 3));
			_highScoreText.setFormat(null, 18, 0xFFFFFF);
			add(_highScoreText);
			
			var _titleLogo:FlxSprite = new FlxSprite(Airplane1945Fight.STAGE_WIDTH/2 - 278/2, Airplane1945Fight.STAGE_HEIGHT/2 - 141/2 - 50, titleLogoImg);
			add(_titleLogo);
			
			var _title:FlxText = new FlxText(_titleLogo.x + 5, _titleLogo.y + 115, 200, "Airplaine FIGHT!");
			_title.setFormat(null, 18, 0xFFFFFF);
			add(_title);
			
			var startButton:FlxButton = new FlxButton(Airplane1945Fight.STAGE_WIDTH/2 - 100/2, _titleLogo.y + 141 + 50, startGame);
			startButton.width = 400;
			var startButtonText:FlxText = new FlxText(8,2,100,"Start Game");
			startButtonText.setFormat(null, 12, 0x000000);
			startButton.loadText(startButtonText);
			add(startButton);
			
			var instructionText:FlxText = new FlxText(_titleLogo.x, startButton.y + 30, 275,
				"Moving: Arrow keys \n" +
				"Fire: Spacebar");
			instructionText.setFormat(null, 14, 0xFFFFFF, "center");
			add(instructionText);
			
			// Show mouse.
			FlxG.mouse.show();
			
			super.create();
		}

		public function startGame():void{
			FlxG.state = new GameState();
		}
	}
}