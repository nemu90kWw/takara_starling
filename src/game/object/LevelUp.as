package game.object
{
	import flash.display3D.Context3DBlendFactor;
	
	import game.core.Root;
	
	import starling.display.BlendMode;

	public class LevelUp extends GameObject
	{
		private var count:int;
		
		override public function initialize():void
		{
			count = 0;
			
			x = Root.STAGE_WIDTH / 2;
			y = Root.STAGE_HEIGHT / 2;
			blendMode = "subtract";
			
			setGraphic("MSG_LEVELUP");
		}
		
		override public function main():void
		{
			currentFrame = Math.floor(count / 2) % 3;
			
			if(count == 4 * 3 * 2)
			{
				vanish();
			}
			
			count++;
		}
	}
}