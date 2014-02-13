package game.scene
{
	import game.core.GameData;
	import game.object.BackGround;
	import game.object.GameObjectPool;
	import game.object.LevelUp;
	import game.object.Player;
	import game.object.Takara;
	
	import starling.display.Sprite;
	
	public class MainGameScene
	{
		private var target:Sprite;
		private var objPool:GameObjectPool;
		
		private var count:int;
		public var gamedata:GameData;
		
		private var level:int;
		private var levelUpBorder:int;
		
		public function MainGameScene(target:Sprite)
		{
			gamedata = new GameData();
			objPool = new GameObjectPool(target, this);
			
			objPool.addObject(new BackGround(), GameObjectPool.LAYER_BG);
			objPool.addObject(new Player(), GameObjectPool.LAYER_PLAYER);
			
			addTakara();
			
			level = 1;
			levelUpBorder = 2;
			
			count = 0;
		}
		
		public function main():void
		{
			if(gamedata.score >= levelUpBorder)
			{
				level++;
				levelUpBorder += level + 1;
				trace(gamedata.score);
				trace(levelUpBorder);
				addTakara();
				
				objPool.addObject(new LevelUp(), GameObjectPool.LAYER_MESSAGE);
			}
			
			objPool.run();
			count++;
		}
		
		public function addTakara():void
		{
			var takara:Takara = new Takara();
			
			takara.x = 270 + Math.random() * 540;
			takara.y = -200;
			takara.vx = 4 - Math.random() * 8;
			takara.rotation = (Math.PI / 180) * 360;
			takara.rot = (Math.PI / 180) * (Math.random() * 2 - 1);
			
			objPool.addObject(takara, GameObjectPool.LAYER_TAKARA);
			return;
		}
	}
}