package org.celstec.ead.web.views.mediators
{
	import flash.events.MouseEvent;
	import org.celstec.ead.events.ViewEvent;
	import org.robotlegs.mvcs.Mediator;
	import spark.events.IndexChangeEvent;
	
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var view:EAD_Web;
		
		override public function onRegister():void
		{
			eventMap.mapListener(view.myTabBar, IndexChangeEvent.CHANGE, handleIndexChange);
		}
		
		private function handleIndexChange(event:IndexChangeEvent):void
		{
			switch(event.currentTarget.selectedItem.id)
			{
				case "rooms":{
					dispatch(new ViewEvent(ViewEvent.INIT_ROOMS));
					break;
				}
				case "groups":{
					dispatch(new ViewEvent(ViewEvent.INIT_GROUPS));
					break;
				}
			}
		}
	}
}