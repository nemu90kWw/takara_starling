package game.object
{
	import game.resources.SpriteSheet;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameObject extends Sprite
	{
		public var layer:GameObjectLayer;
		private var deleteflag:Boolean;
		
		private var image:Image;
		private var imageName:String;
		
		private var _currentFrame:int;
		
		public function main():void
		{
			
		}
		
		// --------------------------------//
		// オブジェクト操作
		// --------------------------------//
		public function vanish():void
		{
			deleteflag = true;
		}
		
		public function exists():Boolean
		{
			return !deleteflag;
		}
		
		// --------------------------------//
		// グラフィック処理
		// --------------------------------//
		public function setGraphic(name:String):void
		{
			imageName = name;
			
			image = SpriteSheet.getImage(name);
			addChild(image);
		}
		
		public function get currentFrame():int {return _currentFrame;}
		public function set currentFrame(value:int):void
		{
			// TODO: 内部で毎回Imageがnewされるため改善の余地あり
			image.texture = SpriteSheet.getImage(imageName, value).texture;
			_currentFrame = value;
		}
	}
}