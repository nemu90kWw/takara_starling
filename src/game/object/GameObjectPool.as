package game.object
{
	import flash.utils.getQualifiedClassName;
	
	import game.core.MasterViewport;
	import game.scene.SceneBase;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameObjectPool
	{
		// enumほしい
		public static const PRIO_TAKARA:String = "PRIO_TAKARA";
		public static const PRIO_PLAYER:String = "PRIO_PLAYER";
		public static const PRIO_EFFECT:String = "PRIO_EFFECT";
		public static const PRIO_SYSTEM:String = "PRIO_SYSTEM";
		
		public static const LAYER_BG:String = "LAYER_BG";
		public static const LAYER_SHADOW:String = "LAYER_SHADOW";
		public static const LAYER_TAKARA:String = "LAYER_TAKARA";
		public static const LAYER_PLAYER:String = "LAYER_PLAYER";
		public static const LAYER_PARTICLE:String = "LAYER_PARTICLE";
		public static const LAYER_MESSAGE:String = "LAYER_MESSAGE";
		public static const LAYER_SCREEN:String = "LAYER_SCREEN";
		
		private var target:Sprite;
		public var scene:SceneBase;
		public var container:Vector.<GameObject>;
		
		private var takaraContainer:Vector.<GameObject>;
		private var playerContainer:Vector.<GameObject>;
		private var effectContainer:Vector.<GameObject>;
		private var systemContainer:Vector.<GameObject>;
		
		private var bgLayer:Sprite;
		private var shadowLayer:Sprite;
		private var takaraLayer:Sprite;
		private var playerLayer:Sprite;
		private var particleLayer:Sprite;
		private var messageLayer:Sprite;
		private var screenLayer:Sprite;
		
		public var lock:Boolean;
		
		public function GameObjectPool(target:Sprite, scene:SceneBase)
		{
			this.target = target;
			this.scene = scene;
			
			lock = false;
			
			takaraContainer = new Vector.<GameObject>;
			playerContainer = new Vector.<GameObject>;
			effectContainer = new Vector.<GameObject>;
			systemContainer = new Vector.<GameObject>;
			
			bgLayer = new Sprite();
			shadowLayer = new Sprite();
			takaraLayer = new Sprite();
			playerLayer = new Sprite();
			particleLayer = new Sprite();
			messageLayer = new Sprite();
			screenLayer = new Sprite();
			
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
			disposeContainer(takaraContainer);
			disposeContainer(playerContainer);
			disposeContainer(effectContainer);
			disposeContainer(systemContainer);
			
			bgLayer.removeChildren();
			takaraLayer.removeChildren();
			playerLayer.removeChildren();
			shadowLayer.removeChildren();
			particleLayer.removeChildren();
			messageLayer.removeChildren();
			screenLayer.removeChildren();
			
			bgLayer.dispose();
			takaraLayer.dispose();
			playerLayer.dispose();
			shadowLayer.dispose();
			particleLayer.dispose();
			messageLayer.dispose();
			screenLayer.dispose();
		}
		
		private function disposeContainer(container:Vector.<GameObject>):void
		{
			for (var i:int = 0; i < container.length; i++) 
			{
				container[i].dispose();
			}
		}
		
		public function run():void
		{
			// 処理順序
			if(lock == false)
			{
				executeContainer(takaraContainer);
				executeContainer(playerContainer);
			}
			executeContainer(effectContainer);
			executeContainer(systemContainer);
			
			// 全て実行後、削除更新処理
			update();
		}
		
		private function updateContainer(container:Vector.<GameObject>):void
		{
			// 削除フラグが立っているものを削除
			for (var i:int = 0; i < container.length; i++) 
			{
				if(container[i].exists() == false)
				{
					container[i].dispose();
					container[i].parent.removeChild(container[i]);
					container.splice(i, 1);
					i--;
				}
			}
		}
		
		private function executeContainer(container:Vector.<GameObject>):void
		{
			for (var i:int = 0; i < container.length; i++) 
			{
				container[i].main();
			}
		}
		
		public function update():void
		{
			updateContainer(takaraContainer);
			updateContainer(playerContainer);
			updateContainer(effectContainer);
			updateContainer(systemContainer);
		}
		
		public function addObject(obj:GameObject):void
		{
			obj.pool = this;
			obj.initialize();
		}
		
		public function registerObject(obj:GameObject, prio:String):void
		{
			switch(prio)
			{
			case PRIO_EFFECT: effectContainer.push(obj); return;
			case PRIO_PLAYER: playerContainer.push(obj); return;
			case PRIO_SYSTEM: systemContainer.push(obj); return;
			case PRIO_TAKARA: takaraContainer.push(obj); return;
			}
			
			trace("ERROR: 無効なプライオリティ"+prio+"が指定されました。"+getQualifiedClassName(obj)+"はオブジェクトコンテナに追加されません。");
		}
		
		public function registerGraphic(obj:GameObject, layer:String):void
		{
			switch(layer)
			{
			case LAYER_BG: bgLayer.addChild(obj); return;
			case LAYER_SHADOW: shadowLayer.addChild(obj); return;
			case LAYER_TAKARA: takaraLayer.addChild(obj); return;
			case LAYER_PLAYER: playerLayer.addChild(obj); return;
			case LAYER_PARTICLE: particleLayer.addChild(obj); return;
			case LAYER_MESSAGE: messageLayer.addChild(obj); return;
			case LAYER_SCREEN: screenLayer.addChild(obj); return;
			}
			
			trace("ERROR: 無効なレイヤー"+layer+"が指定されました。"+getQualifiedClassName(obj)+"は表示ツリーに追加されません。");
		}
		
		public function getObjectList(prio:String):Vector.<GameObject>
		{
			switch(prio)
			{
			case PRIO_EFFECT: return effectContainer;
			case PRIO_PLAYER: return playerContainer;
			case PRIO_SYSTEM: return systemContainer;
			case PRIO_TAKARA: return takaraContainer;
			}
			
			trace("ERROR: 無効なプライオリティ"+prio+"が指定されました。空のVector.<GameObject>を返します");
			return new Vector.<GameObject>;
		}
	}
}