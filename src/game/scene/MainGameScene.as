package game.scene
{
	import game.core.GameData;
	import game.core.MasterViewport;
	import game.object.BackGround;
	import game.object.FadeOut;
	import game.object.GameObject;
	import game.object.GameObjectPool;
	import game.object.GameOver;
	import game.object.LevelUp;
	import game.object.MissCount;
	import game.object.Player;
	import game.object.ReadyGo;
	import game.object.Takara;
	import game.object.Text;
	
	import starling.display.Sprite;
	
	public class MainGameScene extends SceneBase
	{
		private const STATE_READY:String = "ready";
		private const STATE_MAINGAME:String = "maingame";
		private const STATE_GAMEOVER:String = "gameover";
		
		public var gamedata:GameData;
		private var state:String;
		
		private var player:Player;
		
		private var tossCount:int;
		private var level:int;
		private var levelUpBorder:int;
		
		private var scoreText:Text;
		private var missText:Text;
		private var centerMessage:GameObject;
		
		public function MainGameScene(target:Sprite)
		{
			super(target);
			
			// データ初期化
			gamedata = new GameData();
			tossCount = 0;
			level = 1;
			levelUpBorder = 2;
			
			state = STATE_READY;
			
			// 背景
			objPool.addObject(new BackGround());
			
			// ステータス表示
			scoreText = new Text();
			missText = new Text();
			
			scoreText.x = 0;
			scoreText.y = MasterViewport.currentViewport.bottom - 100;
			scoreText.text = "SCORE:0";
			missText.x = 620;
			missText.y = MasterViewport.currentViewport.bottom - 100;
			missText.text = "MISS:";
			
			objPool.addObject(scoreText);
			objPool.addObject(missText);
			
			// 初期配置
			player = new Player();
			objPool.addObject(player);
			
			var takara:Takara = addTakara();
			takara.x = takara.stageWidth / 2 + 10;
			takara.y = 128;
			takara.vx = 0;
			takara.vy = 0;
			takara.rotation = 0.4;
			takara.rot = 0.01;
			
			objPool.run();
		}
		
		// --------------------------------//
		// 状態処理
		// --------------------------------//
		override public function main():void
		{
			switch(state)
			{
			case STATE_READY: actionReady(); break;
			case STATE_MAINGAME: actionMainGame(); break;
			case STATE_GAMEOVER: actionGameOver(); break;
			}
			
			count++;
		}
		
		private function actionReady():void
		{
			if(count == 0)
			{
				setMessage(new ReadyGo());
			}
			
			objPool.run();
			
			if(count == 160)
			{
				player.operate = true;
				
				state = STATE_MAINGAME;
				count = -1;
			}
		}
		
		private function actionMainGame():void
		{
			// レベルアップ
			if(tossCount >= levelUpBorder)
			{
				level++;
				levelUpBorder += level + 1;
				addTakara();
				
				setMessage(new LevelUp());
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
				setMessage(new GameOver());
				objPool.lock = true;
			}
			
			if(count == 150)
			{
				objPool.addObject(new FadeOut());
			}
			
			objPool.run();
			
			if(count == 200)
			{
				root.changeScene(new TitleScene(target));
				return;
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
			obj.x = missText.x + 280 + gamedata.miss * 70;
			obj.y = missText.y + 50;
			objPool.addObject(obj);
			
			gamedata.miss++;
			
			// タカラギコが全て無くなった場合、補填する
			objPool.update();
			if(objPool.getObjectList(GameObjectPool.PRIO_TAKARA).length == 0)
			{
				addTakara();
			}
		}
		
		// --------------------------------//
		// オブジェクト操作
		// --------------------------------//
		public function addTakara():Takara
		{
			var takara:Takara = new Takara();
			
			takara.x = 270 + Math.random() * 540;
			takara.y = MasterViewport.maxViewport.top - 120;
			takara.vx = 4 - Math.random() * 8;
			takara.rotation = (Math.PI / 180) * (Math.random() * 360);
			takara.rot = (Math.PI / 180) * (Math.random() * 2 - 1);
			
			objPool.addObject(takara);
			return takara;
		}
		
		public function setMessage(message:GameObject):void
		{
			if(centerMessage != null)
			{
				centerMessage.vanish();
				objPool.update();
			}
			
			objPool.addObject(message);
			centerMessage = message;
		}
	}
}