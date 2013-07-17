package com.sbrown.view
{
	import com.sbrown.event.RottenTomatoesEvent;
	import com.sbrown.model.vo.MovieVO;
	import com.sbrown.view.ui.ListItem;
	
	import fl.containers.ScrollPane;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.LayoutBox;
	import ui.SliderManager;
	
	public class ListView extends ListViewBase
	{
		public var _listItem:ListItem
		private var _movies:Array;
		private var _layoutBox:LayoutBox;
		private var _scrollHolder:Sprite;
		private var _masker:Sprite;
		
		
		public function ListView()
		{
			_layoutBox = new LayoutBox(30, true);
			addChild(_layoutBox);
			
			setupScrolling();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
//			_layoutBox.x = (stage.stageWidth * .25);
		}		
		
		public function set movies(value:Array):void
		{
			_movies = value;
			makeList();
		}
		
		private function makeList():void
		{
			while(_layoutBox.numChildren > 0)
			{
				_layoutBox.removeChildAt(0);
			}
			
			for each (var movie:MovieVO in _movies) 
			{
				_listItem = new ListItem();
				_listItem.scaleX = _listItem.scaleY = .8;
				_listItem.vo = movie;
				_listItem.addEventListener(MouseEvent.CLICK, onClick);
				_layoutBox.addChild(_listItem);
			}
		}		
		
		private function onClick(event:MouseEvent):void
		{
			var rtEvent:RottenTomatoesEvent = new RottenTomatoesEvent(RottenTomatoesEvent.SHOW_DETAILS);
			rtEvent.vo = event.currentTarget.vo;
			dispatchEvent(rtEvent);
		}
		
		private function setupScrolling():void
		{
			// Need a sprite to hold all of the Things
			_scrollHolder = new Sprite();
			_scrollHolder.y = 50;
			addChild(_scrollHolder);
			
			// We will mask the holder to only display what we want.
			_masker = new Sprite();
			_masker.graphics.beginFill(0xff0000);
			_masker.graphics.drawRect(0,0,1100,600);
			_masker.graphics.endFill();
			_masker.y = _scrollHolder.y;
			addChild(_masker);
			
			_scrollHolder.mask = _masker;
			
			// Adding the things to the holder
			_scrollHolder.addChild(_layoutBox);
			
			// Creating and setting up our slider & manager
			var track:Track = new Track();
			var handle:Handle = new Handle();
			track.addChild(handle);
			
			track.x = 200;
			track.y = 450;
			addChild(track);
			var sMan:SliderManager = new SliderManager();
			sMan.setUpAssets(track,handle);
			sMan.addEventListener(Event.CHANGE,onScroll);
		}
		
		private function onScroll(event:Event):void
		{
			// Grab the percent from the slider manager.
			var pct:Number = SliderManager(event.currentTarget).pct;
			
			// Math : percent * range of motion
			_scrollHolder.x = - pct * (_scrollHolder.width - _masker.width);
			
		}
		
	}
}