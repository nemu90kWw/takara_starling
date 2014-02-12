package game.object
{
	import game.core.Root;

	public class Takara extends GameObject
	{
		private var count:int;
		
		private var vx:Number;
		private var vy:Number;
		private var rot:Number;
		
		override public function initialize():void
		{
			//x = 540;
			//y = 200;
			
			vx = 5;
			vy = 0;
			rot = Math.PI/180 * 5;
			
			setGraphic("OBJ_TAKARA");
		}
		
		override public function main():void
		{
			// 移動
			x += vx;
			y += vy;
			
			vy += 0.1;
			
			rotation += rot;
			rot /= 1.003;
			
			// 画面端はね返り
			if(x < 0)
			{
				x = 0;
				
				vx = -vx/1.5;
				rot /= 1.5;
			}
			if(x > Root.STAGE_WIDTH)
			{
				x = Root.STAGE_WIDTH;
				
				vx = -vx/1.5;
				rot /= 1.5;
			}
			
			// 下はね返り（テスト）
			if(y > 1340)
			{
				vanish();
				vy = -vy;
			}
			
			count++;
		}
	}
}