package game.object
{
	import starling.display.Sprite;

	public class GameObjectLayer extends Sprite
	{
		private var parent:Sprite;
		private var container:Vector.<GameObject>;
		
		public function GameObjectLayer()
		{
			container = new Vector.<GameObject>;
		}
		
		public function addObject(obj:GameObject):GameObject
		{
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
		}
	}

}