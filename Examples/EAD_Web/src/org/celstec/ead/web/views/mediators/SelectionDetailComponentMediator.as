package org.celstec.ead.web.views.mediators
{
	import org.celstec.ead.events.PlugwiseModelEvent;
	import org.celstec.ead.events.SelectionListEvent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.celstec.ead.models.vo.*;
	import org.celstec.ead.web.views.components.SelectionDetailComponent;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class SelectionDetailComponentMediator extends Mediator
	{
		[Inject]
		public var component:SelectionDetailComponent;
		
		[Inject]
		public var model:PlugwiseModel;
		 
		override public function onRegister():void
		{
			//framework events
			eventMap.mapListener(eventDispatcher, SelectionListEvent.CHANGE, handleChange);
			
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.ROOMS_SET, resetLabel);
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.GROUPS_SET, resetLabel);
		}
		
		private function handleChange(event:SelectionListEvent):void
		{
			if(event.selectedItem is Room)
			{
				component.title.text = model.selectedRoom.title;			
				component.powerUsage.text = model.selectedRoom.powerUsage  + " W";
				
				if(model.selectedRoom.powerUsage <= 0){
					component.powerUsage.setStyle("color","Green");
				}
				else if(model.selectedRoom.powerUsage <= 10){
					component.powerUsage.setStyle("color","Yellow");
				}
				else if(model.selectedRoom.powerUsage > 10){
					component.powerUsage.setStyle("color","Red");
				}
				component.totalUsageToday.text = model.selectedRoom.totalUsageToday  + " kWh";
			}
			else if(event.selectedItem is Group)
			{
				component.title.text = model.selectedGroup.title;			
				component.powerUsage.text = model.selectedGroup.powerUsage  + " W";
				
				if(model.selectedGroup.powerUsage <= 0){
					component.powerUsage.setStyle("color","Green");
				}
				else if(model.selectedGroup.powerUsage <= 10){
					component.powerUsage.setStyle("color","Yellow");
				}
				else if(model.selectedGroup.powerUsage > 10){
					component.powerUsage.setStyle("color","Red");
				}
				component.totalUsageToday.text = model.selectedGroup.totalUsageToday  + " kWh";
			}
			else if(event.selectedItem is Appliance)
			{
				component.title.text = event.selectedItem.name;			
				component.powerUsage.text = event.selectedItem.powerUsage  + " W";
				
				if(event.selectedItem.powerUsage <= 0){
					component.powerUsage.setStyle("color","Green");
				}
				else if(event.selectedItem.powerUsage <= 10){
					component.powerUsage.setStyle("color","Yellow");
				}
				else if(event.selectedItem.powerUsage > 10){
					component.powerUsage.setStyle("color","Red");
				}
				component.totalUsageToday.text = event.selectedItem.totalUsageToday  + " kWh";
			}
			
			component.powerUsageLabel.visible = true;
			component.totalUsageTodayLabel.visible = true;
		}
		
		private function resetLabel(event:PlugwiseModelEvent):void
		{
			component.title.text = new String();
			component.powerUsage.text = new String();
			component.powerUsageLabel.visible = false;
			component.totalUsageToday.text = new String();
			component.totalUsageTodayLabel.visible = false;
		}
	}
}