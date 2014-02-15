package game.core
{
	import flash.geom.Rectangle;
	
	import game.resources.SpriteSheet;
	import game.scene.MainGameScene;
	import game.scene.SceneBase;
	import game.scene.SceneController;
	import game.scene.TitleScene;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	// Starlingで作成される本体
	public class MasterViewport extends Sprite
	{
		// 4:3
		public static const STAGE_WIDTH:int = 1080;
		public static const STAGE_HEIGHT:int = 1440;
		
		public static var scale:Number;
		public static var maxHeight:int;
		
		public static var minViewport:Rectangle;
		public static var maxViewport:Rectangle;
		public static var currentViewport:Rectangle;
		
		private var scene:SceneController;
		
		public function MasterViewport()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ROOT_CREATED, onAddedToStage);
			
			// ビットマップフォント追加
			SpriteSheet.registerBitmapFont();
			
			// 表示範囲情報
			minViewport = new Rectangle(0, 0, 1080, 1440);	// 4:3の範囲
			maxViewport = new Rectangle(0, (1440 - 1920) / 2, 1080, 1920);	//16:9の範囲
			currentViewport = new Rectangle(0, maxViewport.y + (1920 - maxHeight) / 2, 1080, maxHeight);	// 現在のディスプレイに表示される範囲
			
			// デバッグ情報を含めたスクリーン全体の表示拡大率の設定
			var masterView:Sprite = new Sprite();
			masterView.y = (maxHeight - 1920) / 2 * scale;
			masterView.scaleX = scale;
			masterView.scaleY = scale;
			addChild(masterView);
			
			// ゲーム画面の表示位置
			var gameview:Sprite = new Sprite();
			gameview.y = (1920 - 1440) / 2;
			masterView.addChild(gameview);
			scene = new SceneController(new TitleScene(gameview));
			/*
			// 表示範囲情報（デバッグ用）
			var smallerView:Frame = new Frame(0, gameview.y, 1080, 1440, 0xFF0000);
			var currentView:Frame = new Frame(0, (1920 - maxHeight) / 2, 1080, maxHeight, 0x00FF00);
			var biggerView:Frame = new Frame(0, 0, 1080, 1920, 0xFF00FF);
			masterView.addChild(smallerView);
			masterView.addChild(currentView);
			masterView.addChild(biggerView);
			*/
			// リスナー登録
			Input.registerListener(stage);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			scene.run();
		}
	}
}
import starling.display.Quad;
import starling.display.Sprite;

class Frame extends Sprite
{
	public function Frame(x:int, y:int, width:int, height:int, color:uint = 0xFF0000)
	{
		var quad:Quad;
		
		quad = new Quad(width, 8, color);
		quad.alpha = 0.3;
		quad.x = x;
		quad.y = y;
		addChild(quad);
		
		quad = new Quad(8, height, color);
		quad.alpha = 0.3;
		quad.x = x;
		quad.y = y;
		addChild(quad);
		
		quad = new Quad(width, 8, color);
		quad.alpha = 0.3;
		quad.x = x;
		quad.y = y + height - 8;
		addChild(quad);
		
		quad = new Quad(8, height, color);
		quad.alpha = 0.3;
		quad.x = x + width - 8;
		quad.y = y;
		addChild(quad);
	}
}