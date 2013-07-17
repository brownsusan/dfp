package com.sbrown.event
{
	import com.sbrown.model.vo.MovieVO;
	
	import flash.events.Event;
	
	public class RottenTomatoesEvent extends Event
	{
		public static const READ_COMPLETE:String = "read_complete";
		public static const SHOW_DETAILS:String = "show_details";
		
		public var vo:MovieVO;
		
		public function RottenTomatoesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}