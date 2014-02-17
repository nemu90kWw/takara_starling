package game.object
{
	import game.core.MasterViewport;

	public class GameOver extends GameObject
	{
		public function GameOver()
		{
			x = stageWidth / 2;
			y = stageHeight / 2;
			blendMode = "subtract";
			
			setGraphic("MSG_GAMEOVER");
		}
	}
}