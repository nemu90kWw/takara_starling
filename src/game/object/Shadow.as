package game.object
{
	public class Shadow extends GameObject
	{
		private var target:GameObject;
		
		public function Shadow(target:GameObject)
		{
			this.target = target;
		}
		
		override public function initialize():void
		{
			y = 1310;
			setGraphic("OBJ_SHADOW");
		}
		
		override public function main():void
		{
			x = target.x;
			
			var float:Number = y - target.y;
			scaleX = 1 - float / 3000;
			scaleY = 1 - float / 3000;
			alpha = 1 - float / 1500;
		}
	}
}