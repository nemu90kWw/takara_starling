package game.object
{
	public class Takara extends GameObject
	{
		private var count:int;
		private var shadow:Shadow;
		
		public var vx:Number;
		public var vy:Number;
		public var rot:Number;
		
		override public function initialize():void
		{
			registerObject(GameObjectPool.PRIO_TAKARA);
			registerGraphic(GameObjectPool.LAYER_TAKARA);
			
			vx = Math.random() * 10 - 5;
			vy = 0;
			rot = Math.PI/180 * 5;
			
			setGraphic("OBJ_TAKARA");
			
			shadow = new Shadow(this);
			addObject(shadow);
		}
		
		override public function main():void
		{
			// 移動
			x += vx;
			y += vy;
			
			vy += 0.07;
			if(vy > 11) {
				vy = 11;
			}
			
			rotation += rot;
			rot /= 1.003;
			
			// 画面端はね返り
			if(x < 0)
			{
				x = 0;
				
				vx = -vx/1.5;
				rot /= 1.5;
			}
			if(x > stageWidth)
			{
				x = stageWidth;
				
				vx = -vx/1.5;
				rot /= 1.5;
			}
			
			// ミス
			if(y > 1310)
			{
				// パーティクルを飛ばす
				for(var i:int = 0; i < 10; i++)
				{
					var particle:StarParticle = new StarParticle();
					
					particle.x = x;
					particle.y = y;
					particle.dir = Math.random() * 360;
					particle.speed = 8 + Math.random() * 32;
					
					addObject(particle);
				}
				
				vanish();
				shadow.vanish();
				
				addMissCount();
			}
			
			count++;
		}
	}
}