package com.sbrown.view
{
	public class SearchView extends SearchViewBase
	{
		public function SearchView()
		{
			this.tfSearch.text = "Fight Club";
			removeChild(loader);
		}
		
		public function getSmaller():void
		{
			this.scaleX = this.scaleY = .5;
		}
		
		public function set loading(value:Boolean):void
		{
			trace(value);
			
			addChild(loader);
			
			if(!value)
			{
				removeChild(loader);
			}
		}
		
	}
}