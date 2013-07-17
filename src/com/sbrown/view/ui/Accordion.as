package com.sbrown.view.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.LayoutBox;
	
	public class Accordion extends Sprite
	{
		private var _panels:Array;
		
		private var _padding:Number;
		private var _isHorizontal:Boolean;
		
		private var _layout:LayoutBox;
		
		public function Accordion()
		{
			super();
			
			_panels = [];
			
			_layout = new LayoutBox();
			addChild(_layout);
		}
		
		public function addPanel(panel:AccordionPanel):void
		{
			panel.heading.addEventListener(MouseEvent.CLICK, onClick);
			_panels.push(panel);
			
			_layout.addChild(panel);
		}
		
		public function removeAll():void
		{
			_panels = [];
			while(_layout.numChildren > 0)
			{
				_layout.removeChildAt(0);
			}
		}
		
		private function onClick(event:MouseEvent):void
		{
			for each (var panel:AccordionPanel in _panels) 
			{
				panel.close();
				trace(panel.height);
			}
			
			AccordionPanel(MovieClip(event.currentTarget).parent).open();
			
			_layout.updatePositioning();
			
		}
		
		public function get panels():Array
		{
			return _panels;
		}
		
	}
}