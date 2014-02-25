package game.object
{
	import game.core.MasterViewport;

	public class GameOver extends GameObject
	{
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_SYSTEM);
			registerGraphic(GameObjectPool.LAYER_MESSAGE);
			
			x = stageWidth / 2;
			y = stageHeight / 2;
			graphic.blendMode = "subtract";
			
			setGraphic("MSG_GAMEOVER");
		}
	}
}