package org.celstec.ead.web.views.mediators
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import org.celstec.ead.events.PlugwiseModelEvent;
	import org.celstec.ead.events.PlugwiseServiceEvent;
	import org.celstec.ead.events.SelectionListEvent;
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.celstec.ead.web.views.components.SelectionListComponent;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class SelectionListComponentMediator extends Mediator
	{
		[Inject]
		public var component:SelectionListComponent;
		
		[Inject]
		public var model:PlugwiseModel;
		 
		override public function onRegister():void
		{
			//framework events
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.ROOMS_SET, updateList);
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.GROUPS_SET, updateList);
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.APPLIANCES_SET, updateList);
			
			eventMap.mapListener(eventDispatcher, PlugwiseServiceEvent.ROOM_APPLIANCES_RESULT, updateApplianceList);
			eventMap.mapListener(eventDispatcher, PlugwiseServiceEvent.GROUP_APPLIANCES_RESULT, updateApplianceList);
			
			//view component events
			eventMap.mapListener(component.list, IndexChangeEvent.CHANGE, handleChange);
			eventMap.mapListener(component.appliancesList, IndexChangeEvent.CHANGE, handleChange);
			
			//dispatch events
			switch(component.id)
			{
				case "roomsSelectionList":{
					dispatch(new ViewEvent(ViewEvent.INIT_ROOMS));
					break;
				}
				case "groupsSelectionList":{
					dispatch(new ViewEvent(ViewEvent.INIT_GROUPS));
					break;
				}
				case "appliancesSelectionList":{
					dispatch(new ViewEvent(ViewEvent.INIT_APPLIANCES));
					break;
				}
			}
		}
		
		private function handleChange(event:IndexChangeEvent):void
		{
			dispatch(new SelectionListEvent(SelectionListEvent.CHANGE, event.currentTarget.selectedItem));
		}
		
		private function updateList(event:PlugwiseModelEvent):void
		{
			switch(event.type)
			{
				case "roomsSet":{
					component.list.dataProvider = model.rooms;
					component.list.labelField = "title";
					component.appliancesList.dataProvider = new ArrayCollection();
					break;
				}
				case "groupsSet":{
					component.list.dataProvider = model.groups;
					component.list.labelField = "title";
					component.appliancesList.dataProvider = new ArrayCollection();
					break;
				}
				case "appliancesSet":{
					component.list.dataProvider = model.appliances;
					component.list.labelField = "name";
					break;
				}
			}
		}
		
		private function updateApplianceList(event:PlugwiseServiceEvent):void
		{
			switch(event.type)
			{
				case "roomAppliancesResult":{
					component.appliancesList.dataProvider = model.selectedRoom.appliances;
					component.appliancesList.labelField = "name";
					break;
				}
				case "groupAppliancesResult":{
					component.appliancesList.dataProvider = model.selectedGroup.appliances;
					component.appliancesList.labelField = "name";
					break;
				}
			}
		}
	}
}