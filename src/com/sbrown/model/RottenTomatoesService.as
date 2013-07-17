package com.sbrown.model
{
	import com.sbrown.event.RottenTomatoesEvent;
	import com.sbrown.model.vo.MovieVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	
	public class RottenTomatoesService extends EventDispatcher
	{
		public static const API_KEY:String = "mmg7n84uaqv38ehxmrjv2xnf";
		
		private var _movies:Array = [];
		
		private var _detailsComplete:uint = 0;
		
		public function RottenTomatoesService()
		{
		}
		
		public function search(keyword:String):void
		{
			_detailsComplete = 0;
			
			var urlLoaderSearch:URLLoader = new URLLoader();
			urlLoaderSearch.addEventListener(IOErrorEvent.IO_ERROR, onErrorSearch);
			urlLoaderSearch.addEventListener(Event.COMPLETE, onSearchComplete);
			urlLoaderSearch.load(new URLRequest("http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=" + keyword + "&apiKey=" + API_KEY));
			
			// THIS IS TEMP
//			public var id:String;
//			public var title:String;
//			public var yearReleased:String;
//			public var mpaaRating:String;
//			public var runTime:String;
//			public var criticRating:String;
//			public var criticScore:String;
//			public var audienceRating:String;
//			public var audienceScore:String;
//			public var cast:Array;
//			public var consensus:String;
//			public var synopsis:String;
//			public var genres:Array;
//			public var reviews:Array;
//			public var posterUrl:String;
			
			/*var vo:MovieVO = new MovieVO();
			_movies = [];

			vo.id = "13153";
			vo.title = "Finding Nemo";
			vo.yearReleased = "1234";
			vo.mpaaRating = "R";
			vo.runTime = "123";
			vo.criticRating = "Good";
			vo.criticScore = "86";
			vo.audienceRating = "Bad";
			vo.audienceScore = "12";
			vo.consensus = "This movie is a movie.";
			vo.cast = ["person1", "person2", "person3", "person4", "person5"];
			vo.posterUrl = "http://content6.flixster.com/movie/10/84/19/10841916_det.jpg";
			vo.genres = ["Drama"];
			vo.reviews = ["review1","review2","review3","review4"];
			
			vo.synopsis = "This is a synopsis";
			vo.posterUrl = "http://content6.flixster.com/movie/10/84/19/10841916_det.jpg";
			
			_movies.push(vo);
			
			// simulated delay of loading
			var myTimer:Timer = new Timer(1000, 1); // 1 second
			myTimer.addEventListener(TimerEvent.TIMER, function(){
				dispatchEvent(new RottenTomatoesEvent(RottenTomatoesEvent.READ_COMPLETE));
			});
			myTimer.start();*/
			
		}
		
		private function onSearchComplete(event:Event):void
		{
			trace("test");
			
			_movies = [];
			
			var jsonObj:Object = JSON.parse(event.currentTarget.data);
			
			for each(var movie:Object in jsonObj.movies)
			{
				var vo:MovieVO = new MovieVO();
				vo.id = movie.id;
				vo.title = movie.title;
				vo.yearReleased = movie.year;
				vo.mpaaRating = movie.mpaa_rating;
				vo.runTime = movie.runtime;
				vo.criticRating = movie.ratings.critics_rating;
				vo.criticScore = movie.ratings.critics_score;
				vo.audienceRating = movie.ratings.audience_rating;
				vo.audienceScore = movie.ratings.audience_score;
				vo.consensus = movie.critics_consensus;
				vo.posterUrl = movie.posters.original;
				_movies.push(vo);
			}
			
			for each (var mov:MovieVO in _movies) 
			{
				var urlLoaderDetails:URLLoader = new URLLoader();
				urlLoaderDetails.addEventListener(Event.COMPLETE, onLoadDetails);
				urlLoaderDetails.addEventListener(IOErrorEvent.IO_ERROR, onErrorDetails);
				urlLoaderDetails.load(new URLRequest("http://api.rottentomatoes.com/api/public/v1.0/movies/" + mov.id + ".json?apikey=" + API_KEY));
			}
			
			
		}
		
		private function onLoadDetails(event:Event):void
		{
			var jsonObjDetails:Object = JSON.parse(event.currentTarget.data);
			
			for each(var movie:MovieVO in _movies)
			{
				if(jsonObjDetails.id == movie.id)
				{
					_detailsComplete++;
					
					movie.genres = jsonObjDetails.genres;
					movie.synopsis = jsonObjDetails.synopsis;
					movie.posterUrl = jsonObjDetails.posters.original;
					movie.cast = jsonObjDetails.abridged_cast;
					break;
				}
			}
			
			sendBackToMain();
			
		}
		 
		private function onErrorSearch(event:IOErrorEvent):void
		{
			//There is an error happening here
		}
		
		private function onErrorDetails(event:IOErrorEvent):void
		{
			_detailsComplete++;
		}
		
		private function sendBackToMain():void
		{
			trace("trying");
			
			if(_detailsComplete == _movies.length)
			{
				trace("sent");
				dispatchEvent(new RottenTomatoesEvent(RottenTomatoesEvent.READ_COMPLETE));
			}
		}
		
		public function get movies():Array
		{
			return _movies;
		}
		
		
	}
}