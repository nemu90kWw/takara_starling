package game.resources
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	
	public class BGMPlayer
	{
		private static const BUFFER_SIZE:int = 4096;
		private static const SAMPLING_RATE:int = 44100;
		
		[Embed(source = "AVC@.mp3")]
		private static var BGM:Class;
		
		private static var stream:Sound = null;
		private static var sound:Sound = null;
		private static var position:Number = 0;
		private static var active:Boolean = true;
		private static var buffer:ByteArray = null;
		
		private static var markers:Vector.<JumpMarker> = null;
		private static var currentMarker:int = 0;
		
		private static var currentMusic:String = null;
		private static var volumes:VolumeContainer = new VolumeContainer();
		
		public static function get masterVolume():Number { return volumes.masterVolume; }
		public static function set masterVolume(value:Number):void {volumes.masterVolume = value; }
		public static function get volume():Number { return volumes.volume; }
		public static function set volume(value:Number):void {volumes.volume = value; }
		
		private static var fadeOutTween:Tween24 = new Tween24();
		private static var deactiveFadeTween:Tween24 = new Tween24();
		
		public static function play(name:String, offset:Number = 0):void
		{
			// 同じ曲は無視する。再生し直す場合は明示的にストップすること
			if(currentMusic == name) {return;}
			
			if(stream != null) {
				stop();
			}
			
			// 曲データの設定
			currentMusic = name;
			markers = new Vector.<JumpMarker>;
			currentMarker = 0;
			
			switch(name)
			{
			case "BGM_MAIN":
				sound = Sound(new BGM());
				markers.push(new JumpMarker(16.5, -8));
				markers.push(new JumpMarker(14.5, 4));
				markers.push(new JumpMarker(28.5, -20));
				break;
			default:
				trace("WARNING: 無効なBGM名が指定されました");
				break;
			}
			
			// 再生位置をサンプル数に変換
			position = Math.round(offset * SAMPLING_RATE);
			
			// ボリュームの初期化
			fadeOutTween.stop();
			volumes.fadeOutVolume = 1;
			
			// 再生開始
			attachStream();
		}
		
		public static function stop():void
		{
			detachStream();
			currentMusic = null;
		}
		
		public static function fadeOut(time:Number = 5):void
		{
			fadeOutTween.stop();
			fadeOutTween = Tween24.tween(volumes, time, Ease24._6_ExpoOut, {fadeOutVolume: 0});
			fadeOutTween.play();
			
			// 同じ曲を再生しなおせるようにする
			currentMusic = null;
		}
		
		private static function attachStream():void
		{
			stream = new Sound();
			
			if(active == true)
			{
				stream.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				volumes.channel = stream.play(0, 0, volumes.transform);
			}
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactive);
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActive);
		}
		
		private static function detachStream():void
		{
			buffer = null;
			
			stream.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, onDeactive);
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, onActive);
			
			volumes.channel.stop();
			fadeOutTween.stop();
			deactiveFadeTween.stop();
			stream = null;
		}
		
		private static function onDeactive(e:Event):void
		{
			if(active == false) { return; }
			
			active = false;
			stream.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			volumes.channel.stop();
		}
		
		private static function onActive(e:Event):void
		{
			if(active == true) { return; }
			
			active = true;
			stream.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			
			// 再開時にフェードインすることでノイズを削減
			volumes.deactiveFadeVolume = 0;
			deactiveFadeTween.stop();
			deactiveFadeTween = Tween24.tween(volumes, 1, Ease24._3_CubicInOut, {deactiveFadeVolume: 1});
			deactiveFadeTween.play();
			
			volumes.channel = stream.play(0, 0, volumes.transform);
		}
		
		private static function onSampleData(e:SampleDataEvent):void
		{
			if(buffer != null)
			{
				// 予め重複部分のデコーダを走らせる
				var temp:ByteArray = new ByteArray();
				sound.extract(temp, BUFFER_SIZE, position);
				
				// クリックノイズの除去
				crossFade(buffer, temp, 64);
				temp.clear();
				
				e.data.writeBytes(buffer);
				buffer.clear();
				buffer = null;
			}
			else {
				sound.extract(e.data, BUFFER_SIZE, position);
			}
			position += BUFFER_SIZE;
			
			// ループ
			if(position >= markers[currentMarker].position)
			{
				// 移動先のデコード結果に欠損が生じやすいため事前に同一部分のバッファを取得
				buffer = new ByteArray();
				sound.extract(buffer, BUFFER_SIZE, position);
				
				position += markers[currentMarker].span;
				currentMarker++;
				
				if(currentMarker >= markers.length) {
					currentMarker = 0;
				}
			}
		}
		
		private static function crossFade(target:ByteArray, source:ByteArray, length:int):void
		{
			var l1:Number, l2:Number, r1:Number, r2:Number;
			var ratio:Number;
			
			source.position = source.length - length * 8;
			target.position = source.position;
			
			for (var i:int = 0; i < length; i++) 
			{
				ratio = i / length;
				
				l1 = target.readFloat();
				r1 = target.readFloat();
				l2 = source.readFloat();
				r2 = source.readFloat();
				
				target.position -= 8;
				target.writeFloat(l1 * (1 - ratio) + l2 * ratio);
				target.writeFloat(r1 * (1 - ratio) + r2 * ratio);
			}
		}
	}
}

class JumpMarker
{
	public var position:int;
	public var span:int;
	
	public function JumpMarker(positionTime:Number, spanTime:Number) 
	{
		position = timeToSamples(positionTime);
		span = timeToSamples(spanTime);
	}
	
	public function timeToSamples(time:Number, rate:int = 44100):int 
	{
		return Math.round(time * rate);
	}
}