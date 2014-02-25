package game.object
{
	import game.resources.SpriteSheet;
	import game.scene.MainGameScene;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class GameObject extends Sprite
	{
		public var pool:GameObjectPool;
		private var deleteflag:Boolean;
		
		private var image:Image;
		private var imageList:Vector.<Texture>;
		
		private var _currentFrame:int;
		
		public function get stageWidth():int
		{
			return 1080;
		}
		
		public function get stageHeight():int
		{
			return 1440;
		}
		
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
		// コンテナへの登録処理
		// --------------------------------//
		public function registerObject(prio:String):void
		{
			pool.registerObject(this, prio);
		}
		
		public function registerGraphic(layer:String):void
		{
			pool.registerGraphic(this, layer);
		}
		
		// --------------------------------//
		// オブジェクト操作
		// --------------------------------//
		public function addObject(obj:GameObject):void
		{
			pool.addObject(obj);
		}
		
		public function getObjectList(prio:String):Vector.<GameObject>
		{
			return pool.getObjectList(prio);
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
			image = SpriteSheet.getImage(name);
			imageList = SpriteSheet.getTextureList(name);
			addChild(image);
		}
		
		public function get currentFrame():int {return _currentFrame;}
		public function set currentFrame(value:int):void
		{
			image.texture = imageList[value];
			_currentFrame = value;
		}
		
		public function get totalFrames():int
		{
			return imageList.length;
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