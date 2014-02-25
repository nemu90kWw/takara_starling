package game.object
{
	public class TitleLogo extends GameObject
	{
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_SYSTEM);
			registerGraphic(GameObjectPool.LAYER_MESSAGE);
			
			setGraphic("MSG_TITLE");
		}
	}
}