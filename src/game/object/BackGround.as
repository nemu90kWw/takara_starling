package game.object
{
	import game.core.Input;

	public class BackGround extends GameObject
	{
		private var count:int;
		private var destX:int;
		
		public function BackGround()
		{
			setGraphic("OBJ_BACK");
			
			// 背景画像は低解像度で格納しているため拡大する
			scaleX = 4;
			scaleY = 4;		
		}
	}
}