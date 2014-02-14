package game.object
{
	import game.core.MasterViewPort;
	import game.scene.SceneBase;
	
	import starling.display.Sprite;

	public class GameObjectPool
	{
		// enumほしい
		public static const LAYER_BG:String = "BG";
		public static const LAYER_SHADOW:String = "SHADOW";
		public static const LAYER_TAKARA:String = "TAKARA";
		public static const LAYER_PLAYER:String = "PLAYER";
		public static const LAYER_PARTICLE:String = "PARTICLE";
		public static const LAYER_MESSAGE:String = "MESSAGE";
		public static const LAYER_SCREEN:String = "SCREEN";
		
		private var target:Sprite;
		public var scene:SceneBase;
		
		private var bgLayer:GameObjectLayer;
		private var shadowLayer:GameObjectLayer;
		private var takaraLayer:GameObjectLayer;
		private var playerLayer:GameObjectLayer;
		private var particleLayer:GameObjectLayer;
		private var messageLayer:GameObjectLayer;
		private var screenLayer:GameObjectLayer;
		
		public var lock:Boolean;
		
		public function GameObjectPool(target:Sprite, scene:SceneBase)
		{
			this.target = target;
			this.scene = scene;
			
			lock = false;
			
			bgLayer = new GameObjectLayer(this);
			shadowLayer = new GameObjectLayer(this);
			takaraLayer = new GameObjectLayer(this);
			playerLayer = new GameObjectLayer(this);
			particleLayer = new GameObjectLayer(this);
			messageLayer = new GameObjectLayer(this);
			screenLayer = new GameObjectLayer(this);
			
			// 表示順序
			target.addChild(bgLayer);
			target.addChild(shadowLayer);
			target.addChild(takaraLayer);
			target.addChild(playerLayer);
			target.addChild(particleLayer);
			target.addChild(messageLayer);
			target.addChild(screenLayer);
		}
		
		public function dispose():void
		{
			bgLayer.dispose();
			takaraLayer.dispose();
			playerLayer.dispose();
			shadowLayer.dispose();
			particleLayer.dispose();
			messageLayer.dispose();
			screenLayer.dispose();
		}
		
		public function run():void
		{
			// 処理順序
			if(lock == false)
			{
				bgLayer.execute();
				takaraLayer.execute();
				playerLayer.execute();
				shadowLayer.execute();
				particleLayer.execute();
				messageLayer.execute();
				screenLayer.execute();
			}
			else
			{
				particleLayer.execute();
				messageLayer.execute();
				screenLayer.execute();
			}
			
			// 全て実行後、削除更新処理
			update();
		}
		
		public function update():void
		{
			bgLayer.update();
			takaraLayer.update();
			playerLayer.update();
			shadowLayer.update();
			particleLayer.update();
			messageLayer.update();
			screenLayer.update();
		}
		
		public function addObject(obj:GameObject, layer:String):void
		{
			switch(layer)
			{
			case LAYER_BG: bgLayer.addObject(obj); break;
			case LAYER_SHADOW: shadowLayer.addObject(obj); break;
			case LAYER_TAKARA: takaraLayer.addObject(obj); break;
			case LAYER_PLAYER: playerLayer.addObject(obj); break;
			case LAYER_PARTICLE: particleLayer.addObject(obj); break;
			case LAYER_MESSAGE: messageLayer.addObject(obj); break;
			case LAYER_SCREEN: screenLayer.addObject(obj); break;
			}
		}
		
		public function getObjectList(layer:String):Vector.<GameObject>
		{
			switch(layer)
			{
			case LAYER_BG: return bgLayer.container; break;
			case LAYER_SHADOW: return shadowLayer.container; break;
			case LAYER_TAKARA: return takaraLayer.container; break;
			case LAYER_PLAYER: return playerLayer.container; break;
			case LAYER_PARTICLE: return particleLayer.container; break;
			case LAYER_MESSAGE: return messageLayer.container; break;
			case LAYER_SCREEN: return screenLayer.container; break;
			}
			
			return null;
		}
	}
}