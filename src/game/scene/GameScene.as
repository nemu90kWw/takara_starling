package game.scene
{
	import game.core.GameData;
	import game.core.Root;
	import game.object.BackGround;
	import game.object.GameObjectPool;
	import game.object.LevelUp;
	import game.object.Player;
	import game.object.Takara;
	import game.object.Text;
	
	import starling.display.Sprite;
	
	public class GameScene
	{
		protected var target:Sprite;
		protected var objPool:GameObjectPool;
		
		protected var count:int;
		
		public function GameScene(target:Sprite)
		{
			objPool = new GameObjectPool(target, this);
			
			count = 0;
		}
		
		public function main():void
		{
		}
	}
}