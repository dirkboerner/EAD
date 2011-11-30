package org.celstec.ead.mobile.views.mediators
{
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.mobile.views.SelectedRoomView;
	import org.celstec.ead.mobile.views.SelectedGroupView;
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var view:EAD_Mobile;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ViewEvent.ROOM_SELECTED, handleSelection);
			eventMap.mapListener(eventDispatcher, ViewEvent.GROUP_SELECTED, handleSelection);
			eventMap.mapListener(eventDispatcher, ViewEvent.ROOM_BACK, handleBackButton);
			eventMap.mapListener(eventDispatcher, ViewEvent.GROUP_BACK, handleBackButton);
		}
		
		private function handleSelection(event:ViewEvent):void
		{
			switch(event.type)
			{
				case "roomSelected":
					view.roomsViewNavigator.pushView(SelectedRoomView);
					break;
				case "groupSelected":
					view.groupsViewNavigator.pushView(SelectedGroupView);
					break;
			}
		}
		
		private function handleBackButton(event:ViewEvent):void
		{
			switch(event.type)
			{
				case "roomBack":
					view.roomsViewNavigator.popView();
					break;
				case "groupBack":
					view.groupsViewNavigator.popView();
					break;
			}
		}
	}
}