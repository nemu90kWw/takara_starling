package game.scene
{
	import game.core.GameData;
	import game.core.Root;
	import game.object.BackGround;
	import game.object.GameObjectPool;
	import game.object.LevelUp;
	import game.object.MissCount;
	import game.object.Player;
	import game.object.Takara;
	import game.object.Text;
	
	import starling.display.Sprite;
	
	public class MainGameScene extends GameScene
	{
		public var gamedata:GameData;
		
		private var tossCount:int;
		private var level:int;
		private var levelUpBorder:int;
		
		private var scoreText:Text;
		private var missText:Text;
		
		public function MainGameScene(target:Sprite)
		{
			super(target);
			
			// データ初期化
			gamedata = new GameData();
			tossCount = 0;
			level = 1;
			levelUpBorder = 2;
			
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
			objPool.addObject(new Player(), GameObjectPool.LAYER_PLAYER);
			var takara:Takara = addTakara();
			takara.x = Root.STAGE_WIDTH / 2;
			takara.y = 200;
			takara.vx = 0;
			takara.vy = 0;
			takara.rotation = 0.4;
			takara.rot = 0.01;
		}
		
		override public function main():void
		{
			if(tossCount >= levelUpBorder)
			{
				level++;
				levelUpBorder += level + 1;
				addTakara();
				
				objPool.addObject(new LevelUp(), GameObjectPool.LAYER_MESSAGE);
			}
			
			objPool.run();
			
			count++;
		}
		
		public function addScore(value:int):void
		{
			tossCount++;
			gamedata.score += value;
			scoreText.text = "SCORE:" + gamedata.score;
		}
		
		public function addMissCount():void
		{
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
			takara.rotation = (Math.PI / 180) * 360;
			takara.rot = (Math.PI / 180) * (Math.random() * 2 - 1);
			
			objPool.addObject(takara, GameObjectPool.LAYER_TAKARA);
			return takara;
		}
	}
}