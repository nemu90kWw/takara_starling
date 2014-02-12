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
		}
	}
}