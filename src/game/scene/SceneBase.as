package game.scene
{
	import game.object.GameObjectPool;
	
	import starling.display.Sprite;
	
	public class SceneBase
	{
		public var root:SceneController;
		
		protected var target:Sprite;
		protected var objPool:GameObjectPool;
		
		protected var count:int;
		
		public function SceneBase(target:Sprite)
		{
			this.target = target;
			objPool = new GameObjectPool(target, this);
			
			count = 0;
		}
		
		public function main():void
		{
		}
		
		public function dispose():void
		{
			objPool.dispose();
		}
	}
}