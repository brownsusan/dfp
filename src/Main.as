package
{
	import com.sbrown.event.RottenTomatoesEvent;
	import com.sbrown.model.RottenTomatoesService;
	import com.sbrown.view.DetailView;
	import com.sbrown.view.ListView;
	import com.sbrown.view.SearchView;
	
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	[SWF(width="1108", height="730", frameRate="30", backgroundColor="0xEEEEEE")]
	
	public class Main extends Sprite
	{
		private var _rottenTomatoesService:RottenTomatoesService = new RottenTomatoesService();
		private var _searchView:SearchView;
		private var _listView:ListView;
		private var _detailView:DetailView;
		
		public function Main()
		{
			_rottenTomatoesService.addEventListener(RottenTomatoesEvent.READ_COMPLETE, onReadComplete);
			
			var background:BackgroundBase = new BackgroundBase();
			addChild(background);
			background.y = -28;
			
			//add the search view
			_searchView = new SearchView();
			addChild(_searchView);
			_searchView.x = stage.stageWidth*.5;
			_searchView.y = stage.stageHeight*.5;
			_searchView.button.addEventListener(MouseEvent.CLICK, onSearch);
			
			_listView = new ListView();
			_listView.y = 100;
//			_listView.x = 50;
			_listView.addEventListener(RottenTomatoesEvent.SHOW_DETAILS, onShowDetails);
			
			_detailView = new DetailView();
			_detailView.x = 75;
			_detailView.backButton.addEventListener(MouseEvent.CLICK, onBack);
			
			//CONTEXT MENU
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			var mItem:ContextMenuItem = new ContextMenuItem("Copyright ©2013 Susan Brown", true);
			mItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, copyrightClick);
			cm.customItems.push(mItem);
			//Next line determines what can be right clicked on
			this.contextMenu = cm;
			
		}
		
		protected function copyrightClick(event:ContextMenuEvent):void
		{
			var uRequest:URLRequest = new URLRequest("http://www.fullsail.edu");
			navigateToURL(uRequest, "_blank");
		}		
		
		private function onSearch(event:MouseEvent):void
		{
			_searchView.loading = true;
			_rottenTomatoesService.search(_searchView.tfSearch.text);
			_searchView.getSmaller();
			_searchView.y = 70;
			
			//Need to remove the previously added listview
			addChild(_listView);
			
			addChild(_detailView);
			removeChild(_detailView);
		}
		
		private function onReadComplete(event:RottenTomatoesEvent):void
		{
			_searchView.loading = false;
			_listView.movies = _rottenTomatoesService.movies;
			addChild(_listView);
		}	
		
		private function onShowDetails(event:RottenTomatoesEvent):void
		{
			addChild(_listView);
			removeChild(_listView);
			
			_detailView.vo = event.vo;
			addChild(_detailView);
		}
		
		private function onBack(event:MouseEvent):void
		{	
			//splice things from the rt movArray before adding more
			_rottenTomatoesService.search(_searchView.tfSearch.text);
			addChild(_detailView);
			removeChild(_detailView);
			
			_listView.movies = _rottenTomatoesService.movies;
			addChild(_listView);
			_listView.y = 100;
			
			//not working
			trace("I am happening");
			
		}
		
	}
}