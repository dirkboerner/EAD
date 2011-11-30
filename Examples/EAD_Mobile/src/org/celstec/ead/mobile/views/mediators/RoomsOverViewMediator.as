package org.celstec.ead.mobile.views.mediators
{
	import flash.events.MouseEvent;
	
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.mobile.views.RoomsOverView;
	import org.celstec.ead.models.PlugwiseModel;
	import org.robotlegs.mvcs.Mediator;
	
	public class RoomsOverViewMediator extends Mediator
	{
		[Inject]
		public var roomsOverView:RoomsOverView;
		
		override public function onRegister():void
		{		
			//view component events
			eventMap.mapListener(roomsOverView.refreshButton, MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(event:MouseEvent):void
		{
			dispatch(new ViewEvent(ViewEvent.ROOMS_REFRESH));
		}
	}
}