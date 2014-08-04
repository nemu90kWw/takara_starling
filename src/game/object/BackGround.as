package game.object
{
	public class BackGround extends GameObject
	{
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_SYSTEM);
			registerGraphic(GameObjectPool.LAYER_BG);
			setGraphic("OBJ_BACK");
			
			// 背景画像は低解像度で格納しているため拡大する
			scaleX = 4;
			scaleY = 4;		
		}
	}
}