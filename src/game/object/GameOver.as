package game.object
{
	import game.core.MasterViewport;

	public class GameOver extends GameObject
	{
		public function GameOver()
		{
			x = MasterViewport.STAGE_WIDTH / 2;
			y = MasterViewport.STAGE_HEIGHT / 2;
			blendMode = "subtract";
			
			setGraphic("MSG_GAMEOVER");
		}
	}
}