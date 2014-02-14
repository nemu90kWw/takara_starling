package game.object
{
	import game.resources.SpriteSheet;
	import game.scene.MainGameScene;
	
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
		
		override public function dispose():void
		{
			super.dispose();
			
			if(image != null)
			{
				image.dispose();
				image = null;
			}
		}
		
		// --------------------------------//
		// オブジェクト操作
		// --------------------------------//
		public function addObject(obj:GameObject, layer:String):void
		{
			pool.addObject(obj, layer);
		}
		
		public function getObjectList(layer:String):Vector.<GameObject>
		{
			return pool.getObjectList(layer);
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
		
		// --------------------------------//
		// データ操作
		// --------------------------------//
		public function addScore(value:int):void
		{
			if(pool.scene is MainGameScene == true)
			{
				MainGameScene(pool.scene).addScore(value);
			}
		}
		
		public function addMissCount():void
		{
			if(pool.scene is MainGameScene == true)
			{
				MainGameScene(pool.scene).addMissCount();
			}
		}
	}
}