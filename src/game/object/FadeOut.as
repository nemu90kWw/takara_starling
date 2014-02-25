package game.object
{
	import game.core.MasterViewport;
	
	import starling.display.Quad;

	public class FadeOut extends GameObject
	{
		private var effect:Quad;
		
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_SYSTEM);
			registerGraphic(GameObjectPool.LAYER_SCREEN);
			
			effect = new Quad(MasterViewport.currentViewport.width, MasterViewport.currentViewport.height, 0);
			effect.x = MasterViewport.currentViewport.x;
			effect.y = MasterViewport.currentViewport.y;
			effect.alpha = 0;
			graphic.addChild(effect);
		}
		
		override public function main():void
		{
			effect.alpha = (1 + effect.alpha * 7) / 8;
		}
	}
}