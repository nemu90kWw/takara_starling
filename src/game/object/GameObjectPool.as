package game.object
{
	import game.core.Root;
	
	import starling.display.Sprite;

	public class GameObjectPool
	{
		// enumほしい
		public static const LAYER_BG:String = "BG";
		public static const LAYER_SHADOW:String = "SHADOW";
		public static const LAYER_TAKARA:String = "TAKARA";
		public static const LAYER_PLAYER:String = "PLAYER";
		public static const LAYER_PARTICLE:String = "PARTICLE";
		
		private var root:Sprite;
		
		private var bgLayer:GameObjectLayer;
		private var shadowLayer:GameObjectLayer;
		private var takaraLayer:GameObjectLayer;
		private var playerLayer:GameObjectLayer;
		private var particleLayer:GameObjectLayer;
		
		public function GameObjectPool(root:Sprite)
		{
			this.root = root;
			
			bgLayer = new GameObjectLayer(this);
			shadowLayer = new GameObjectLayer(this);
			takaraLayer = new GameObjectLayer(this);
			playerLayer = new GameObjectLayer(this);
			particleLayer = new GameObjectLayer(this);
			
			// 表示順序
			root.addChild(bgLayer);
			root.addChild(shadowLayer);
			root.addChild(takaraLayer);
			root.addChild(playerLayer);
			root.addChild(particleLayer);
		}
		
		public function run():void
		{
			// 処理順序
			bgLayer.execute();
			takaraLayer.execute();
			playerLayer.execute();
			shadowLayer.execute();
			particleLayer.execute();
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
			}
			
			return null;
		}
	}
}