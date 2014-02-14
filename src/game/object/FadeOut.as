package game.object
{
	import game.core.MasterViewPort;
	
	import starling.display.Quad;

	public class FadeOut extends GameObject
	{
		private var effect:Quad;
		
		public function FadeOut()
		{
			effect = new Quad(MasterViewPort.STAGE_WIDTH, MasterViewPort.STAGE_HEIGHT, 0);
			effect.x = 0;
			effect.y = 0;
			effect.alpha = 0;
			addChild(effect);
		}
		
		override public function main():void
		{
			effect.alpha = (1 + effect.alpha * 7) / 8;
		}
	}
}