package game.object
{
	import game.resources.SpriteSheet;
	import game.scene.MainGameScene;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class GameObject
	{
		public var pool:GameObjectPool;
		private var deleteflag:Boolean;
		
		public var graphic:Sprite = new Sprite();
		
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
		// 委譲処理
		// --------------------------------//
		public function get x():Number {return graphic.x;}
		public function set x(value:Number):void {graphic.x = value;}
		
		public function get y():Number {return graphic.y;}
		public function set y(value:Number):void {graphic.y = value;}
		
		public function get scaleX():Number {return graphic.scaleX;}
		public function set scaleX(value:Number):void {graphic.scaleX = value;}
		
		public function get scaleY():Number {return graphic.scaleY;}
		public function set scaleY(value:Number):void {graphic.scaleY = value;}
		
		public function get rotation():Number {return graphic.rotation;}
		public function set rotation(value:Number):void {graphic.rotation = value;}
		
		public function get alpha():Number {return graphic.alpha;}
		public function set alpha(value:Number):void {graphic.alpha = value;}
		
		public function get visible():Boolean {return graphic.visible;}
		public function set visible(value:Boolean):void {graphic.visible = value;}
		
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
		
		public function dispose():void
		{
			graphic.removeChildren();
			graphic = null;
			
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
			graphic.addChild(image);
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