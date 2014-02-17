package game.object
{
	import flash.display3D.Context3DBlendFactor;
	
	import game.core.MasterViewport;
	
	import starling.display.BlendMode;

	public class LevelUp extends GameObject
	{
		private var count:int;
		
		override public function initialize():void
		{
			count = 0;
			
			x = stageWidth / 2;
			y = stageHeight / 2;
			blendMode = "subtract";
			
			setGraphic("MSG_LEVELUP");
		}
		
		override public function main():void
		{
			currentFrame = Math.floor(count / 2) % totalFrames;
			
			if(count == (2 * totalFrames) * 4)
			{
				vanish();
			}
			
			count++;
		}
	}
}