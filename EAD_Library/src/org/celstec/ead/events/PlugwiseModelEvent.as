package org.celstec.ead.events
{
	import flash.events.Event;
	
	public class PlugwiseModelEvent extends Event
	{
		public static const ROOMS_SET:String = "roomsSet";
		public static const GROUPS_SET:String = "groupsSet";
		public static const APPLIANCES_SET:String = "appliancesSet";

		public function PlugwiseModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new PlugwiseModelEvent(type, bubbles, cancelable)
		}
	}
}