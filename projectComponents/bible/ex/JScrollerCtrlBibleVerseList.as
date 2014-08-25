package projectComponents.bible.ex
{
	import mx.core.UIComponent;
	
	import spark.components.VGroup;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.views.item.BibleItem;
	
	public class JScrollerCtrlBibleVerseList extends JScrollerCtrlBibleBase
	{
		protected var gr:VGroup
		protected var nScrollerValue:Number
		
		
		public function JScrollerCtrlBibleVerseList(_ctrl:JScrollerActBase,_data:BibleDB)
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
			nLength = sql.getBible().length
			addItem(0,nLength)
		}
		
		
		
		override public function next():void
		{
			super.next()
			nLength = sql.getBible().length
			addItem(0,nLength)
		}
		
		
		override public function prev():void
		{
			super.prev()
			nLength = sql.getBible().length
			addItem(0,nLength)
		}
		
		
		override protected function createItem(_index:uint):UIComponent
		{
			var _item:BibleItem = new BibleItem
			_item.$data=(currModel.getBibleData(sql,_index))
			_item.percentWidth = 100;
			return _item
		}
		
		
		
		
		
		
		override public function load():void
		{
			super.load()
			scrollerCtrl._removeAllElement()
			scroller.stopAnimations()
			
			nLength = sql.getBible().length
			addItem(0,nLength)
			
		}
		
	}
}



