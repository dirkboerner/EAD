package org.celstec.ead.events
{
	import flash.events.Event;
	
	public class ViewEvent extends Event
	{
		public static const INIT_ROOMS:String = "initRooms";
		public static const INIT_GROUPS:String = "initGroups";
		public static const INIT_APPLIANCES:String = "initAppliances";
		
		public static const ROOM_SELECTED:String = "roomSelected";
		public static const GROUP_SELECTED:String = "groupSelected";
		
		public static const ROOM_BACK:String = "roomBack";
		public static const GROUP_BACK:String = "groupBack";
		
		public static const ROOMS_REFRESH:String = "roomsRefresh";
		public static const GROUPS_REFRESH:String = "groupsRefresh";
		
		public function ViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ViewEvent(type, bubbles, cancelable)
		}
	}
}