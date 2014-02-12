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
			count = 0;
			rot = Math.PI / 180 * (Math.random() * 20 - 10);
			
			setGraphic("OBJ_STAR");
		}
		
		override public function main():void
		{
			speed /= 1.08;
			rotation += rot;
			
			x += Math.cos(Math.PI / 180 *dir) * speed;
			y += Math.sin(Math.PI / 180 *dir) * speed;
			
			if(count > 2)
			{
				scaleX /= 1.06;
				scaleY /= 1.06;
			}
			if(count > 40)
			{
				alpha /= 1.2;
			}
			
			if(count == 80)
			{
				vanish();
			}
			
			count++;
			return;
		}
	}
}