package com.sbrown.view.ui
{
	import com.sbrown.model.vo.MovieVO;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class ListItem extends ListItemBase
	{
		private var _vo:MovieVO;
		private var isHovered:Boolean = true;
		private var _hover:HoverDetails = new HoverDetails();
		
		public function ListItem()
		{
			addEventListener(MouseEvent.MOUSE_OVER, onHover);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		public function set vo(value:MovieVO):void
		{
			_vo = value;
			loadPoster();
		}
		
		public function get vo():MovieVO
		{
			return _vo;
		}
		
		private function loadPoster():void
		{
			trace(_vo.title);
			var _url:String = _vo.posterUrl;
			trace(_url);
			var ld:Loader = new Loader();
			ld.load(new URLRequest(_url));
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
		}
		
		protected function onImageLoaded(event:Event):void
		{
			var image:Bitmap;
			image = new Bitmap(event.target.content.bitmapData);
			image.width = this.backdrop.width;
			image.height = this.backdrop.height;
			var mh:Number = stage.stageHeight;
			this.backdrop.addChild(image);
			
		}
		
		protected function onHover(event:MouseEvent):void
		{
			this.backdrop.addChild(_hover);
			_hover.tfTitle.text = _vo.title;
			_hover.tfYear.text = _vo.yearReleased;
			_hover.x = this.width * .5 - 70;
			_hover.y = this.height * .5;
		}
		
		protected function onOut(event:MouseEvent):void
		{
			this.backdrop.removeChild(_hover);
			
		}
		
	}
}