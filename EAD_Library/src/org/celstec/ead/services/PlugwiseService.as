package org.celstec.ead.services
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.celstec.ead.events.PlugwiseServiceEvent;
	import org.celstec.ead.services.parser.IPlugwiseServiceParser;
	import org.robotlegs.mvcs.Actor;
	
	public class PlugwiseService extends Actor implements IPlugwiseService
	{
		private var service:HTTPService;
		private var _parser:IPlugwiseServiceParser;
		
		[Inject]
		public function set parser(value:IPlugwiseServiceParser):void
		{
			_parser = value;
		}
		
		//Insert URL to the Plugwise Data API
		private const PLUGWISE_BASE_URL:String = "";

		public function PlugwiseService()
		{
			service = new HTTPService();
			service.addEventListener(FaultEvent.FAULT, httpFault);
		}
		
		public function readType(type:String):void
		{
			var parameters:Object = new Object();
			parameters.type = type;
			
			service.method = "GET";
			service.resultFormat = "e4x";
			service.url = PLUGWISE_BASE_URL;
			switch(type)
			{
				case "rooms":{
					service.addEventListener(ResultEvent.RESULT, readRoomsResult);
					break;
				}
				case "groups":{
					service.addEventListener(ResultEvent.RESULT, readGroupsResult);
					break;
				}
				case "appliances":{
					service.addEventListener(ResultEvent.RESULT, readAppliancesResult);
					break;
				}
			}
			service.send(parameters);
		}
		
		private function readRoomsResult(event:ResultEvent):void
		{	
			var rooms:ArrayCollection = _parser.parseRooms(event.result);
			
			dispatch(new PlugwiseServiceEvent(PlugwiseServiceEvent.ROOMS_RESULT, rooms));
			service.removeEventListener(ResultEvent.RESULT, readRoomsResult);
		}
		
		private function readGroupsResult(event:ResultEvent):void
		{	
			var groups:ArrayCollection = _parser.parseGroups(event.result);
			
			dispatch(new PlugwiseServiceEvent(PlugwiseServiceEvent.GROUPS_RESULT, groups));
			service.removeEventListener(ResultEvent.RESULT, readGroupsResult);
		}
		
		private function readAppliancesResult(event:ResultEvent):void
		{	
			var appliances:ArrayCollection = _parser.parseAppliances(event.result);
			
			dispatch(new PlugwiseServiceEvent(PlugwiseServiceEvent.APPLIANCES_RESULT, appliances));
			service.removeEventListener(ResultEvent.RESULT, readAppliancesResult);
		}
		
		public function readRoom(id:String):void
		{
			var parameters:Object = new Object();
			parameters.type = "appliances";
			parameters.roomid = id;
			
			service.method = "GET";
			service.resultFormat = "e4x";
			service.url = PLUGWISE_BASE_URL;
			service.addEventListener(ResultEvent.RESULT, readRoomResult);
			
			service.send(parameters);
		}
		
		private function readRoomResult(event:ResultEvent):void
		{	
			var appliances:ArrayCollection = _parser.parseAppliances(event.result);
			
			dispatch(new PlugwiseServiceEvent(PlugwiseServiceEvent.ROOM_APPLIANCES_RESULT, appliances));
			service.removeEventListener(ResultEvent.RESULT, readRoomResult);
		}
		
		public function readGroup(id:String):void
		{
			var parameters:Object = new Object();
			parameters.type = "appliances";
			parameters.groupid = id;
			
			service.method = "GET";
			service.resultFormat = "e4x";
			service.url = PLUGWISE_BASE_URL;
			service.addEventListener(ResultEvent.RESULT, readGroupResult);
			
			service.send(parameters);
		}
		
		private function readGroupResult(event:ResultEvent):void
		{	
			var appliances:ArrayCollection = _parser.parseAppliances(event.result);
			
			dispatch(new PlugwiseServiceEvent(PlugwiseServiceEvent.GROUP_APPLIANCES_RESULT, appliances));
			service.removeEventListener(ResultEvent.RESULT, readGroupResult);
		}

		private function httpFault(event:FaultEvent):void
		{
			trace(event.fault);
		}
	}
}