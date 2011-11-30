package org.celstec.ead.services.parser
{
	import mx.collections.ArrayCollection;

	public interface IPlugwiseServiceParser
	{
		function parseRooms(resultObject:Object):ArrayCollection;
		function parseGroups(resultObject:Object):ArrayCollection;
		function parseAppliances(resultObject:Object):ArrayCollection;
	}
}