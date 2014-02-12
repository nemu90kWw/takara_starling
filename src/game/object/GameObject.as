package game.object
{
	import game.resources.SpriteSheet;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameObject extends Sprite
	{
		public var pool:GameObjectPool;
		private var deleteflag:Boolean;
		
		private var image:Image;
		private var imageName:String;
		
		private var _currentFrame:int;
		
		// --------------------------------//
		// 共通処理
		// --------------------------------//
		public function initialize():void
		{
			// 参照パラメータ設定後に呼ばれる処理
		}
		
		public function main():void
		{
			// 毎フレーム処理
		}
		
		// --------------------------------//
		// オブジェクト操作
		// --------------------------------//
		public function addObject(obj:GameObject, layer:String):void
		{
			pool.addObject(obj, layer);
		}
		
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