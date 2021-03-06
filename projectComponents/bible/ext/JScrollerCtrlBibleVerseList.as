package projectComponents.bible.ext
{
	import flash.geom.Rectangle;
	
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	import mx.utils.Platform;
	
	import spark.components.VGroup;
	
	import JsC.debug.CountTime;
	import JsC.events.JEvent;
	
	import JsF.components.scroller.act.JScrollerActBase;
	import JsF.components.scroller.act.JScrollerActDropScroller_desktop;
	
	import projectComponents.bible.ctrl.DataBibleController;
	import projectComponents.bible.viewers.item.BibleVerseList_item;
	import projectComponents.bible.vo.BibleOB;
	
	
	[Event(name="ITEM_CREATE", type="JsC.events.JEvent")]
	
	
	public class JScrollerCtrlBibleVerseList extends JScrollerCtrlBibleBase
	{
		protected var gr:VGroup
		protected var nScrollerValue:Number
		private var jscroll_desktop:JScrollerActDropScroller_desktop
		
		public function JScrollerCtrlBibleVerseList(_ctrl:JScrollerActBase,_data:DataBibleController)
		{
			super(_ctrl,_data);
			
			cLength = sql.$length
			cTotal = sql.$total
			
			scrollerCtrl.$slider = 40;
				
			gr = scrollerCtrl._getContentV()
			gr.gap = 7
				
			addEventListener(JEvent.ADDED,onJEvent)
			
			jscroll_desktop = new JScrollerActDropScroller_desktop(scroller,gr)
		}
		
		protected function onJEvent(event:JEvent):void
		{
			/** 當未充滿一個版面時，加入一個空間*/
			var _ph:Number = scroller.height
			var _eb:Rectangle = gr.layout.getElementBounds(gr.numElements-1)
			var _gh:Number = _eb.y + _eb.height
			var _nH:Number = _ph - _gh
			if(_nH > 0)
			{
				var h:uint = (Platform.isDesktop)? 0 : 1
				var sp:Spacer = new Spacer
				sp.height = _nH - gr.gap + h
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
				
				var _event:JEvent = new JEvent(JEvent.ITEM_CREATE)
				_event._obj = _item
				dispatchEvent(_event)
			}
			return _item
		}
		
		
		
		
		override public function load():void
		{
			jscroll_desktop.stop()
			super.load()
			gr.regenerateStyleCache(true)
			scrollerCtrl._removeAllElement()
			scroller.stopAnimations()
			nLength = sql.getBible().length
			addItem(0,nLength)
		}
		
	}
}



