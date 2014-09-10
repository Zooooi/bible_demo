package projectComponents.bible.ext
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	
	import spark.components.VGroup;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActBase;
	
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.act.ActItem_BibleVerseList;
	import projectComponents.bible.ctrl.DataBibleController;
	import projectComponents.bible.viewers.item.BibleVerseList_item;
	
	
	[Event(name="NEWGAME", type="JsC.events.JEvent")]
	[Event(name="SELECT", type="JsC.events.JEvent")]
	
	public class JScrollerCtrlBibleVerseList extends JScrollerCtrlBibleBase
	{
		protected var gr:VGroup
		protected var nScrollerValue:Number
		
		
		public function JScrollerCtrlBibleVerseList(_ctrl:JScrollerActBase,_data:DataBibleController)
		{
			super(_ctrl,_data);
			
			cLength = sql.$length
			cTotal = sql.$total
			
			scrollerCtrl.$slider = 40;
			gr = scrollerCtrl._getContentV()
			gr.gap = 7
				
			addEventListener(JEvent.ADDED,onJEvent)
		}
		
		protected function onJEvent(event:JEvent):void
		{
			/** 當未充滿一個版面時，加入一個空間*/
			var _ph:Number = scroller.parent.height
			var _eb:Rectangle = gr.layout.getElementBounds(gr.numElements-1)
			var _gh:Number = _eb.y + _eb.height
			var _nH:Number = _ph - _gh
			if(_nH > 0)
			{
				var sp:Spacer = new Spacer
				sp.height = _nH -1
				gr.addElement(sp)
			}
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
			CountTime.display("bible list createItem")
			var _vo:BibleOB = currModel.getBibleData(sql,_index)
			var _item:BibleVerseList_item
			if (_vo.content !="")
			{
				_item = new BibleVerseList_item
				_item.$data=currModel.getBibleData(sql,_index)
				var itemCtrl:ActItem_BibleVerseList = new ActItem_BibleVerseList(_item)
				itemCtrl.addEventListener(JEvent.NEWGAME,onItemJEvent)	
				itemCtrl.addEventListener(JEvent.SELECT,onItemJEvent)	
				
			}
			return _item
		}
		
		protected function onItemJEvent(event:JEvent):void
		{
			var _event:JEvent = new JEvent(event.type)
			_event._vo = event._vo
			dispatchEvent(_event)
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



