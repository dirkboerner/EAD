package org.celstec.ead.events
{
	import flash.events.Event;
	
	public class SelectionListEvent extends Event
	{
		public static const CHANGE:String = "change";
		
		public var selectedItem:Object;
		
		public function SelectionListEvent(type:String, selectedItem:Object , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.selectedItem = selectedItem;
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new SelectionListEvent(type, selectedItem, bubbles, cancelable)
		}
	}
}