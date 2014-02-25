package game.object
{
	public class StarParticle extends GameObject
	{
		public var dir:Number;
		public var speed:Number;
		
		private var count:int;
		private var rot:Number;
		
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_EFFECT);
			registerGraphic(GameObjectPool.LAYER_PARTICLE);
			
			count = 0;
			
			rotation = (Math.PI / 180) * (Math.random() * 360);
			rot = (Math.PI / 180) * (Math.random() * 20 - 10);
			
			setGraphic("OBJ_STAR");
		}
		
		override public function main():void
		{
			speed /= 1.08;
			rotation += rot;
			
			x += Math.cos(Math.PI / 180 *dir) * speed;
			y += Math.sin(Math.PI / 180 *dir) * speed;
			
			if(count > 5)
			{
				scaleX /= 1.05;
				scaleY /= 1.05;
			}
			if(count > 50)
			{
				alpha /= 1.2;
			}
			
			if(count == 100)
			{
				vanish();
			}
			
			count++;
			return;
		}
	}
}