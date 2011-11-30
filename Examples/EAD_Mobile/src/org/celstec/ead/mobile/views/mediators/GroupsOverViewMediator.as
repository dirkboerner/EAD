package org.celstec.ead.mobile.views.mediators
{
	import flash.events.MouseEvent;
	
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.mobile.views.GroupsOverView;
	import org.celstec.ead.models.PlugwiseModel;
	import org.robotlegs.mvcs.Mediator;
	
	public class GroupsOverViewMediator extends Mediator
	{
		[Inject]
		public var groupsOverView:GroupsOverView;
		
		override public function onRegister():void
		{		
			//view component events
			eventMap.mapListener(groupsOverView.refreshButton, MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(event:MouseEvent):void
		{
			dispatch(new ViewEvent(ViewEvent.GROUPS_REFRESH));
		}
	}
}