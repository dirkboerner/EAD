package org.celstec.ead.services
{
	import org.celstec.ead.services.parser.IPlugwiseServiceParser;

	public interface IPlugwiseService
	{
		function readType(type:String):void;
		function readRoom(id:String):void;
		function readGroup(id:String):void;
		
		function set parser(value:IPlugwiseServiceParser):void;
	}
}