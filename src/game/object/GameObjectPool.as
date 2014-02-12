package game.object
{
	import game.core.Root;
	
	import starling.display.Sprite;

	public class GameObjectPool
	{
		public static const LAYER_BG:String = "BG";
		public static const LAYER_SHADOW:String = "SHADOW";
		public static const LAYER_TAKARA:String = "TAKARA";
		public static const LAYER_PLAYER:String = "PLAYER";
		
		private var root:Sprite;
		
		private var bgLayer:GameObjectLayer;
		private var shadowLayer:GameObjectLayer;
		private var takaraLayer:GameObjectLayer;
		private var playerLayer:GameObjectLayer;
		
		public function GameObjectPool(root:Sprite)
		{
			this.root = root;
			
			bgLayer = new GameObjectLayer(this);
			shadowLayer = new GameObjectLayer(this);
			takaraLayer = new GameObjectLayer(this);
			playerLayer = new GameObjectLayer(this);
			
			// 表示順序
			root.addChild(bgLayer);
			root.addChild(shadowLayer);
			root.addChild(playerLayer);
			root.addChild(takaraLayer);
			
			bgLayer.addObject(new BackGround());
			playerLayer.addObject(new Player());
			
			for (var i:int = 0; i < 10; i++) 
			{
				var takara:Takara = new Takara();
				takara.x = Math.random() * Root.STAGE_WIDTH;
				takara.y = Math.random() * 500;
				takaraLayer.addObject(takara);
			}
		}
		
		public function run():void
		{
			// 処理順序
			bgLayer.execute();
			takaraLayer.execute();
			playerLayer.execute();
			shadowLayer.execute();
		}
		
		public function registerObject(obj:GameObject, layer:String):void
		{
			switch(layer)
			{
			case LAYER_BG: bgLayer.addObject(obj); break;
			case LAYER_SHADOW: shadowLayer.addObject(obj); break;
			case LAYER_TAKARA: takaraLayer.addObject(obj); break;
			case LAYER_PLAYER: playerLayer.addObject(obj); break;
			}
		}
	}
}