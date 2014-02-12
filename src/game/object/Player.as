package game.object
{
	import game.core.Input;

	public class Player extends GameObject
	{
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
			//移動
			if(Input.down == true)
			{
				var preX:Number = x;
				destX = Input.touchX;
			}
			
			x = (x * 4 + destX) / 5;
			
			//アニメーション
			if(x - preX < -12) {
				currentFrame = 7+count%3;
			}
			else if(x - preX > 12) {
				currentFrame = 10+count%3;
			}
			else if(x - preX < -2) {
				currentFrame = 1+count%3;
			}
			else if(x - preX > 2) {
				currentFrame = 4+count%3;
			}
			else {
				currentFrame = 0;
			}
			
			count++;
		}
	}
}