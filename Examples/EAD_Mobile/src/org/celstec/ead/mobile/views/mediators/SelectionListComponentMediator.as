package org.celstec.ead.mobile.views.mediators
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import org.celstec.ead.events.ViewEvent;
	import org.celstec.ead.events.PlugwiseModelEvent;
	import org.celstec.ead.events.SelectionListEvent;
	import org.celstec.ead.mobile.views.RoomsOverView;
	import org.celstec.ead.mobile.views.components.SelectionListComponent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.collections.SortField;
	import spark.components.IconItemRenderer;
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
			
			//view component events
			eventMap.mapListener(component.list, IndexChangeEvent.CHANGE, handleChange);
			
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
			dispatch(new SelectionListEvent(SelectionListEvent.CHANGE, component.list.selectedItem));
			if(component.id != "appliancesSelectionList")
				component.busyIndicator.visible = true;
		}
		
		private function updateList(event:PlugwiseModelEvent):void
		{
			switch(event.type)
			{
				case "roomsSet":{
					component.list.dataProvider = model.rooms;
					component.list.labelField = "title";
					component.busyIndicator.visible = false;
					break;
				}
				case "groupsSet":{
					component.list.dataProvider = model.groups;
					component.list.labelField = "title";
					component.busyIndicator.visible = false;
					break;
				}
				case "appliancesSet":{
					component.list.dataProvider = model.appliances;
					component.list.labelField = "name";
					component.busyIndicator.visible = false;
					break;
				}
			}
		}
	}
}