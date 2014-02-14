package game.object
{
	import game.core.Root;

	public class GameOver extends GameObject
	{
		public function GameOver()
		{
			x = Root.STAGE_WIDTH / 2;
			y = Root.STAGE_HEIGHT / 2;
			blendMode = "subtract";
			
			setGraphic("MSG_GAMEOVER");
		}
	}
}