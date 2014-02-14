package game.scene
{
	import game.core.GameData;
	import game.core.Root;
	import game.object.BackGround;
	import game.object.GameObjectPool;
	import game.object.GameOver;
	import game.object.LevelUp;
	import game.object.MissCount;
	import game.object.Player;
	import game.object.Takara;
	import game.object.Text;
	
	import starling.display.Sprite;
	
	public class MainGameScene extends GameScene
	{
		private const STATE_MAINGAME:String = "maingame";
		private const STATE_GAMEOVER:String = "gameover";
		
		public var gamedata:GameData;
		private var state:String;
		
		private var tossCount:int;
		private var level:int;
		private var levelUpBorder:int;
		
		private var scoreText:Text;
		private var missText:Text;
		private var levelUpMessage:LevelUp;
		
		public function MainGameScene(target:Sprite)
		{
			super(target);
			
			// データ初期化
			gamedata = new GameData();
			tossCount = 0;
			level = 1;
			levelUpBorder = 2;
			
			state = STATE_MAINGAME;
			
			// 背景
			objPool.addObject(new BackGround(), GameObjectPool.LAYER_BG);
			
			// ステータス表示
			scoreText = new Text();
			missText = new Text();
			
			scoreText.x = 0;
			scoreText.y = Root.STAGE_HEIGHT - 100;
			scoreText.text = "SCORE:0";
			missText.x = 620;
			missText.y = Root.STAGE_HEIGHT - 100;
			missText.text = "MISS:";
			
			objPool.addObject(scoreText, GameObjectPool.LAYER_MESSAGE);
			objPool.addObject(missText, GameObjectPool.LAYER_MESSAGE);
			
			// 初期配置
			var takara:Takara = addTakara();
			takara.x = Root.STAGE_WIDTH / 2;
			takara.y = 200;
			takara.vx = 0;
			takara.vy = 0;
			takara.rotation = 0.4;
			takara.rot = 0.01;
			
			objPool.addObject(new Player(), GameObjectPool.LAYER_PLAYER);
			
			addTakara();
			addTakara();
			addTakara();
			addTakara();
			addTakara();
			addTakara();
		}
		
		// --------------------------------//
		// 状態処理
		// --------------------------------//
		override public function main():void
		{
			switch(state)
			{
			case STATE_MAINGAME: actionMainGame(); break;
			case STATE_GAMEOVER: actionGameOver(); break;
			}
			
			count++;
		}
		
		private function actionMainGame():void
		{
			// レベルアップ
			if(tossCount >= levelUpBorder)
			{
				level++;
				levelUpBorder += level + 1;
				addTakara();
				
				levelUpMessage = new LevelUp();
				objPool.addObject(levelUpMessage, GameObjectPool.LAYER_MESSAGE);
			}
			
			objPool.run();
			
			// ミス３回でゲームオーバー移行
			if(gamedata.miss >= 3)
			{
				state = STATE_GAMEOVER;
				count = -1;
			}
		}
		
		private function actionGameOver():void
		{
			if(count == 0)
			{
				if(levelUpMessage != null)
				{
					levelUpMessage.vanish();
					objPool.update();
				}
				
				objPool.addObject(new GameOver(), GameObjectPool.LAYER_MESSAGE);
			}
		}
		
		// --------------------------------//
		// データ操作
		// --------------------------------//
		public function addScore(value:int):void
		{
			tossCount++;
			gamedata.score += value;
			scoreText.text = "SCORE:" + gamedata.score;
		}
		
		public function addMissCount():void
		{
			if(gamedata.miss >= 3) { return; }
			
			var obj:MissCount = new MissCount();
			obj.x = missText.x + 260 + gamedata.miss * 80;
			obj.y = missText.y + 50;
			objPool.addObject(obj, GameObjectPool.LAYER_MESSAGE);
			
			gamedata.miss++;
		}
		
		public function addTakara():Takara
		{
			var takara:Takara = new Takara();
			
			takara.x = 270 + Math.random() * 540;
			takara.y = -200;
			takara.vx = 4 - Math.random() * 8;
			takara.rotation = (Math.PI / 180) * (Math.random() * 360);
			takara.rot = (Math.PI / 180) * (Math.random() * 2 - 1);
			
			objPool.addObject(takara, GameObjectPool.LAYER_TAKARA);
			return takara;
		}
	}
}