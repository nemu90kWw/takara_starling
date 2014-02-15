package game.object
{
	import game.core.MasterViewport;

	public class ReadyGo extends GameObject
	{
		private var count:int;
		public function ReadyGo()
		{
			x = MasterViewport.STAGE_WIDTH / 2;
			y = MasterViewport.STAGE_HEIGHT / 2;
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