package game.object
{
	public class MissCount extends GameObject
	{
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_SYSTEM);
			registerGraphic(GameObjectPool.LAYER_MESSAGE);
			
			setGraphic("OBJ_TAKARA");
			
			scaleX = 0.5;
			scaleY = 0.5;
		}
	}
}