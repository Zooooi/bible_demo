package projectComponents.bible.ctrl
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import spark.components.VGroup;
	
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.act.ActBibleItem;
	import projectComponents.bible.views.item.BibleItem;
	
	public class CreateBible_VerseList extends CreateBible_Base
	{
		protected var gr:VGroup
		protected var nScrollerValue:Number
		
		
		public function CreateBible_VerseList(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl,_data);
			
				
			cLength = sql.$length
			cTotal = sql.$total
			
			scrollerCtrl.$slider = 30;
			gr = scrollerCtrl._getContentV()
		}
		
		
		override public function init():void
		{
			super.init()
			nLength = cTotal
			addItem(0,cTotal)
		}
		
		
		override public function next():void
		{
			super.next()
			addItem(0,cLength)
		}
		
		
		override public function prev():void
		{
			super.prev()
			nLength = cLength
			addItem(0,nLength)
		}
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _item:BibleItem = new BibleItem
			_item.$data=(currModel.getBibleData(sql,_index))
			_item.percentWidth = 100;
			new ActBibleItem(_item);
			return _item
		}
		
		
	}
}



