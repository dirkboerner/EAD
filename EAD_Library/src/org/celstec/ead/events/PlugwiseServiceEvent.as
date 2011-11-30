package org.celstec.ead.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class PlugwiseServiceEvent extends Event
	{
		public static const ROOMS_RESULT:String = "roomsResult";
		public static const GROUPS_RESULT:String = "groupsResult";
		public static const APPLIANCES_RESULT:String = "appliancesResult";
		
		public static const ROOM_APPLIANCES_RESULT:String = "roomAppliancesResult";
		public static const GROUP_APPLIANCES_RESULT:String = "groupAppliancesResult";
		
		private var _resultAC:ArrayCollection;
		
		public function get resultAC():ArrayCollection
		{
			return _resultAC;
		}
		
		public function PlugwiseServiceEvent(type:String, resultAC:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_resultAC = resultAC;
		}

		override public function clone():Event
		{
			return new PlugwiseServiceEvent(type, resultAC, bubbles, cancelable)
		}
	}
}