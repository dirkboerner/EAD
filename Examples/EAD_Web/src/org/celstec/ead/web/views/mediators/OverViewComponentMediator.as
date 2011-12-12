package org.celstec.ead.web.views.mediators
{
	import mx.charts.series.AreaSeries;
	import mx.collections.ArrayCollection;
	import mx.events.IndexChangedEvent;
	import mx.events.ItemClickEvent;
	
	import org.celstec.ead.events.PlugwiseModelEvent;
	import org.celstec.ead.events.PlugwiseServiceEvent;
	import org.celstec.ead.events.SelectionListEvent;
	import org.celstec.ead.models.PlugwiseModel;
	import org.celstec.ead.models.vo.*;
	import org.celstec.ead.web.views.components.OverViewComponent;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class OverViewComponentMediator extends Mediator
	{
		[Inject]
		public var component:OverViewComponent;
		
		[Inject]
		public var model:PlugwiseModel;
		
		private var myPictogramChartAC:ArrayCollection = new ArrayCollection([   
			{name:"Campus²", totalUsageToday:3674},    
			{name:"Chiba²", totalUsageToday:548},    
			{name:"Employee²", totalUsageToday:6.7},
			{name:"", totalUsageToday:0},
		]); 
		 
		override public function onRegister():void
		{
			//framework events
			eventMap.mapListener(eventDispatcher, SelectionListEvent.CHANGE, handleSelection);
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.ROOMS_SET, resetCharts);
			eventMap.mapListener(eventDispatcher, PlugwiseModelEvent.GROUPS_SET, resetCharts);
			
			eventMap.mapListener(eventDispatcher, PlugwiseServiceEvent.ROOM_APPLIANCES_RESULT, updateCharts);
			eventMap.mapListener(eventDispatcher, PlugwiseServiceEvent.GROUP_APPLIANCES_RESULT, updateCharts);
			
			//component events
			eventMap.mapListener(component.selectionGroup, ItemClickEvent.ITEM_CLICK, handleClick);
			eventMap.mapListener(component.selectionGroup2, ItemClickEvent.ITEM_CLICK, handleClick2);
		}
		
		private function handleSelection(event:SelectionListEvent):void
		{
			if(event.selectedItem is Appliance)
			{
				myPictogramChartAC[3].name = event.selectedItem.name + "¹";
				myPictogramChartAC[3].totalUsageToday = event.selectedItem.totalUsageToday;
				component.myPictogramChartDataProvider = myPictogramChartAC;
				if(component.myViewStack.selectedIndex == 1)
					component.myPictogramChart.updatePercentages();
				
				component.myAreaChart.series[0].displayName = event.selectedItem.name;
				component.logDayAC = event.selectedItem.logday;
				component.logWeekAC = event.selectedItem.logweek;
				switch(component.selectionGroup2.selectedValue)
				{
					case "week":{
						component.myAreaChartDataProvider = component.logWeekAC;
						component.myAreaChartCategoryField = "date";
						break;
					}
					case "today":{
						component.myAreaChartDataProvider = component.logDayAC;
						component.myAreaChartCategoryField = "time";
						break
					}
				}
			}
			else
			{
				component.myAreaChartDataProvider = new ArrayCollection();
			}
		}
		
		private function resetCharts(event:PlugwiseModelEvent):void
		{
			switch(event.type)
			{
				case "roomsSet":{
					component.myTreeMapDataProvider = model.rooms;
					component.myPictogramChartDataProvider = new ArrayCollection();
					component.myAreaChartDataProvider = new ArrayCollection();
					break;
				}
				case "groupsSet":{
					component.myTreeMapDataProvider = model.groups;
					component.myPictogramChartDataProvider = new ArrayCollection();
					component.myAreaChartDataProvider = new ArrayCollection();
					break;
				}
			}
			component.myTreeMapLabelField = "title";
		}
		
		private function updateCharts(event:PlugwiseServiceEvent):void
		{
			switch(event.type)
			{
				case "roomAppliancesResult":{
					component.myTreeMapDataProvider = model.selectedRoom.appliances;
					myPictogramChartAC[3].name = model.selectedRoom.title + "¹";
					myPictogramChartAC[3].totalUsageToday = model.selectedRoom.totalUsageToday;
					component.myPictogramChartDataProvider = myPictogramChartAC;
					break;
				}
				case "groupAppliancesResult":{
					component.myTreeMapDataProvider = model.selectedGroup.appliances;
					myPictogramChartAC[3].name = model.selectedGroup.title + "¹";
					myPictogramChartAC[3].totalUsageToday = model.selectedGroup.totalUsageToday;
					component.myPictogramChartDataProvider = myPictogramChartAC;
					break;
				}
			}
			component.myTreeMapLabelField = "name";
			
			if(component.myViewStack.selectedIndex == 1)
				component.myPictogramChart.updatePercentages();
		}
		
		private function handleClick(event:ItemClickEvent):void
		{
			component.myTreeMapAreaField = event.currentTarget.selectedValue;
			component.myTreeMap.refresh();
		}
		
		private function handleClick2(event:ItemClickEvent):void
		{
			switch(event.item)
			{
				case "week":{
					component.myAreaChartDataProvider = component.logWeekAC;
					component.myAreaChartCategoryField = "date";
					break;
				}
				case "today":{
					component.myAreaChartDataProvider = component.logDayAC;
					component.myAreaChartCategoryField = "time";
					break
				}
			}
		}
	}
}