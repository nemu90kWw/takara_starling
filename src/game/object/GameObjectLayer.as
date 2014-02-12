package game.object
{
	import starling.display.Sprite;

	public class GameObjectLayer extends Sprite
	{
		private var pool:GameObjectPool;
		private var container:Vector.<GameObject>;
		
		public function GameObjectLayer(pool:GameObjectPool)
		{
			this.pool = pool;
			container = new Vector.<GameObject>;
		}
		
		public function addObject(obj:GameObject):GameObject
		{
			obj.pool = pool;
			
			obj.initialize();
			
			container.push(obj);
			addChild(obj);
			return obj;
		}
		
		public function execute():void
		{
			for (var i:int = 0; i < container.length; i++) 
			{
				container[i].main();
			}
			
			// 削除フラグが立っているものを削除
			for (i = 0; i < container.length; i++) 
			{
				if(container[i].exists() == false)
				{
					removeChild(container[i]);
				}
			}
		}
	}
}