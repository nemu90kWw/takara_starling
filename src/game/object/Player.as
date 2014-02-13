package game.object
{
	import game.core.Input;

	public class Player extends GameObject
	{
		private const MAX_SPEED:Number = 80;
		
		private var count:int;
		private var destX:int;
		
		override public function initialize():void
		{
			x = 540;
			y = 1200;
			
			destX = 540;
			
			setGraphic("OBJ_PLAYER");
			addObject(new Shadow(this), GameObjectPool.LAYER_SHADOW);
		}
		
		override public function main():void
		{
			// 移動
			if(Input.down == true) {
				destX = Input.touchX;
			}
			
			var speed:Number = (x * 4 + destX) / 5 - x;
			
			if(speed > MAX_SPEED) {
				speed = MAX_SPEED;
			}
			if(speed < -MAX_SPEED) {
				speed = -MAX_SPEED;
			}
			
			x += speed;
			
			// アニメーション
			if(speed < -12) {
				currentFrame = 7 + count % 3;
			}
			else if(speed > 12) {
				currentFrame = 10 + count % 3;
			}
			else if(speed < -2) {
				currentFrame = 1 + count % 3;
			}
			else if(speed > 2) {
				currentFrame = 4 + count % 3;
			}
			else {
				currentFrame = 0;
			}
			
			// 当たり判定
			var list:Vector.<GameObject> = getObjectList(GameObjectPool.LAYER_TAKARA);
			for (var i:int = 0; i < list.length; i++) 
			{
				var takara:Takara = Takara(list[i]);
				
				// 上昇中のものへの多重ヒットを防ぐ
				if(takara.vy < 0) { continue; }
				
				if(x - 120 < takara.x && x + 120 > takara.x && y - 150 < takara.y)
				{
					// 位置の差と移動速度による打ち上げ方の違いを設定
					var gap:int = (takara.x - x) / 2 + speed * 2;
					takara.vx += gap / 8;
					takara.vy = -16+Math.abs(gap) / 30;
					takara.rot += (Math.PI / 180) * gap / 10;
					
					// 中間点からパーティクルを出す
					for(var j:int = 0; j < 2; j++)
					{
						var particle:StarParticle = new StarParticle();
						
						particle.x = x + (takara.x - x) / 2;
						particle.y = y + (takara.y - y) / 2;
						particle.dir = Math.random() * 360;
						particle.speed = 12 + Math.random() * 4;
						
						addObject(particle, GameObjectPool.LAYER_PARTICLE);
					}
				}
			}
			
			count++;
		}
	}
}