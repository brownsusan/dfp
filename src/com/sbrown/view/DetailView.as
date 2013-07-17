package com.sbrown.view
{
	import com.sbrown.model.vo.MovieVO;
	import com.sbrown.view.ui.Accordion;
	import com.sbrown.view.ui.AccordionPanel;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class DetailView extends DetailViewBase
	{
		public var _mVO:MovieVO;
		
		public var _accordion:Accordion;
		
		public function DetailView()
		{	
			//will need an image loader for the link provided in json
			//can use the list item and scale up a bit
			var backButton:BackButtonBase = new BackButtonBase();
			
			_accordion = new Accordion();
			addChild(_accordion);
			_accordion.x = this.largeListItem.x + this.largeListItem.width + 100;
			_accordion.y = this.largeListItem.y;
		}		
		
		public function set vo(value:MovieVO):void
		{
			_mVO = value;
			update();
		}
		
		private function update():void
		{
			_accordion.removeAll();
			
			trace(_mVO.title);
			
			var textFields:TextFields = new TextFields();
			textFields.tfTitle.text = _mVO.title + "";
			textFields.tfYear.text ="Released: " + _mVO.yearReleased;
			textFields.tfGenre.text ="Genre: " + _mVO.genres[0];
			textFields.tfRuntime.text = "Runtime: " + _mVO.runTime + " m";
			textFields.tfMpaaRating.text = "Rated " + _mVO.mpaaRating;
			textFields.tfSynopsis.text = "Synopsis" + _mVO.synopsis + "";
			textFields.tfCast.text = "" + _mVO.cast;
			textFields.tfCriticScore.text = _mVO.criticScore + "";
			textFields.tfCriticRating.text = _mVO.criticRating + "";
			textFields.tfAudienceScore.text = _mVO.audienceScore + "";
			textFields.tfAudiencceRating.text = _mVO.audienceRating + "";
			textFields.tfConsensus.text = _mVO.consensus + "";
			
			
			//Description Panel
			var accordianPanel1:AccordionPanel = new AccordionPanel();
			_accordion.addPanel(accordianPanel1);
			accordianPanel1.heading.tfHeader.text = "Details";
			accordianPanel1.panel.addChild(textFields.tfTitle);
			accordianPanel1.panel.addChild(textFields.tfYear);
			accordianPanel1.panel.addChild(textFields.tfGenre);
			accordianPanel1.panel.addChild(textFields.tfRuntime);
			accordianPanel1.panel.addChild(textFields.tfMpaaRating);
			accordianPanel1.panel.addChild(textFields.tfSynopsis);
			textFields.tfTitle.x = textFields.tfTitle.y = 60;
			textFields.tfYear.y = 80;
			textFields.tfGenre.y = 100;
			textFields.tfRuntime.y = 120;
			textFields.tfMpaaRating.y = 140;
			textFields.tfSynopsis.y = 160;
			
			//Cast
			var accordianPanel2:AccordionPanel = new AccordionPanel();
			_accordion.addPanel(accordianPanel2);
			accordianPanel2.heading.tfHeader.text = "Cast";
			accordianPanel2.panel.addChild(textFields.tfCast);
			textFields.tfCast.y = 50;
			
			//Rating
			var accordianPanel3:AccordionPanel = new AccordionPanel();
			_accordion.addPanel(accordianPanel3);
			accordianPanel3.heading.tfHeader.text = "Ratings";
			accordianPanel3.panel.addChild(textFields.tfCriticScore);
			accordianPanel3.panel.addChild(textFields.tfCriticRating);
			accordianPanel3.panel.addChild(textFields.tfAudienceScore);
			accordianPanel3.panel.addChild(textFields.tfAudiencceRating);
			accordianPanel3.panel.addChild(textFields.tfConsensus);
			textFields.tfCriticScore.y = 60;
			textFields.tfCriticRating.y = 80;
			textFields.tfAudienceScore.y = 100;
			textFields.tfAudiencceRating.y = 120;
			textFields.tfConsensus.y = 140;
			
			//Reviews
			var accordianPanel4:AccordionPanel = new AccordionPanel();
			_accordion.addPanel(accordianPanel4);
			accordianPanel4.heading.tfHeader.text = "Reviews";
			accordianPanel4.panel.addChild(textFields.tfReviews);
			textFields.tfReviews.y = 60;
			
			var _url:String = _mVO.posterUrl;
			var ld:Loader = new Loader();
			ld.load(new URLRequest(_url));
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
		}
		
		protected function onImageLoaded(event:Event):void
		{
			var image:Bitmap;
			image = new Bitmap(event.target.content.bitmapData);
			image.width = this.bigBackDrop.width;
			image.height = this.bigBackDrop.height;
			//var mh:Number = stage.stageHeight;
			this.bigBackDrop.addChild(image);
			
		}
		
	}
}