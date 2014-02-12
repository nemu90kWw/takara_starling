package game.object
{
	import starling.display.Sprite;

	public class GameObjectLayer extends Sprite
	{
		private var container:Vector.<GameObject>;
		
		public function GameObjectLayer()
		{
			container = new Vector.<GameObject>;
		}
		
		public function addObject(obj:GameObject):GameObject
		{
			container.push(obj);
			
			obj.layer = this;
			
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