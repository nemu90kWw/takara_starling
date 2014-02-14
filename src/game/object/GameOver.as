package game.object
{
	import game.core.MasterViewPort;

	public class GameOver extends GameObject
	{
		public function GameOver()
		{
			x = MasterViewPort.STAGE_WIDTH / 2;
			y = MasterViewPort.STAGE_HEIGHT / 2;
			blendMode = "subtract";
			
			setGraphic("MSG_GAMEOVER");
		}
	}
}