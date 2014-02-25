package game.object
{
	import game.core.MasterViewport;

	public class ReadyGo extends GameObject
	{
		private var count:int;
		
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_SYSTEM);
			registerGraphic(GameObjectPool.LAYER_MESSAGE);
			
			x = stageWidth / 2;
			y = stageHeight / 2;
			blendMode = "subtract";
			
			count = 0;
			visible = false;
			setGraphic("MSG_READYGO");
		}
		
		override public function main():void
		{
			if(count == 40)
			{
				visible = true;
			}
			if(count == 120)
			{
				visible = false;
			}
			if(count == 160)
			{
				visible = true;
				currentFrame = 1;
			}
			if(count == 200)
			{
				vanish();
			}
			count++;
		}
	}
}