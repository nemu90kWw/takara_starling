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
			// 位置を同期（実行順序上、他オブジェクトの移動より後に呼ばれる）
			x = target.x;
			
			// 対象の位置が高いほど薄く小さく
			var float:Number = y - target.y;
			scaleX = 1 - float / 3000;
			scaleY = 1 - float / 3000;
			alpha = 1 - float / 1500;
		}
	}
}